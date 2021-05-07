from django.http import JsonResponse
from django.http import HttpRequest
from rest_framework import status
from rest_framework.decorators import api_view

from dating.models.ClientSerializer import ClientSerializer
from dating.services.ClientService import ClientService


@api_view(['POST'])
def create(request: HttpRequest) -> JsonResponse:
    """
    Handles POST requests.
    :param request: request object.
    :return: HTTP response in JSON format with serialized data.
    """

    service = ClientService()
    result = service.create(request)
    if result['errors']:
        return JsonResponse(result, status=status.HTTP_400_BAD_REQUEST)
    else:
        result['data'] = ClientSerializer(result['data']).data
        return JsonResponse(result, status=status.HTTP_201_CREATED)


@api_view(['GET'])
def get_list(request: HttpRequest) -> JsonResponse:
    """
    Handles GET requests.
    :param request: request object.
    :return: HTTP response in JSON format with serialized data.
    """

    service = ClientService()
    result = service.read(request)
    if result['errors']:
        return JsonResponse(result, status=status.HTTP_400_BAD_REQUEST)
    else:
        result['data'] = [ClientSerializer(c).data for c in result['data']]
        return JsonResponse(result)
