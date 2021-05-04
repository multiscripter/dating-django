import json

from channels.routing import URLRouter
from channels.testing import ChannelsLiveServerTestCase
from channels.testing import WebsocketCommunicator


# Run TestClient from project root using unittests:
# python manage.py test chat.tests.testFunctional
from django.urls import path

from chat.services.ChatConsumer import ChatConsumer


class ChatTests(ChannelsLiveServerTestCase):
    """Functional tests for ChatConsumer."""

    serve_static = True  # emulate StaticLiveServerTestCase

    async def test_send_message(self):
        uri = 'ws/chat/chat-room-1/'

        application = URLRouter([
            path(r'ws/chat/<room_name>/', ChatConsumer.as_asgi())
        ])
        client1 = WebsocketCommunicator(application, uri)
        client2 = WebsocketCommunicator(application, uri)
        connected1, subprotocol1 = await client1.connect()
        connected2, subprotocol2 = await client2.connect()

        expected = json.dumps({"message": "test message"})
        await client1.send_to(expected)
        actual = await client2.receive_from()

        await client1.disconnect()
        await client2.disconnect()
        self.assertEqual(expected, actual)
