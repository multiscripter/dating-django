# Run TestClient from project root using unittests:
# python manage.py test chat.tests.TestChatConsumer


# class TestChatConsumer(TestCase):
#     async def test_my_consumer(self):
#         communicator = HttpCommunicator(ChatConsumer, "GET", "/test/")
#         response = await communicator.get_response()
#         self.assertEqual(response["body"], b"test response")
#         self.assertEqual(response["status"], 200)
