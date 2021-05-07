from django.http import HttpResponseNotModified
from django.http import JsonResponse
from rest_framework import status
from rest_framework.decorators import api_view

from dating.models.MatchSerializer import MatchSerializer
from dating.services.MatchService import MatchService


@api_view(['POST'])
def create(request, from_id):
    """
    Handles POST requests.
    :param request: request object.
    :param from_id: match initializer`s id.
    :return: HTTP response in JSON format with serialized data.
    """

    service = MatchService()
    result = service.read(request, from_id)
    if len(result['data']):
        if not result['data'][0].is_mutually:
            u_result = service.update(
                result['data'][0], {'is_mutually': True}
            )
            if u_result['errors']:
                return JsonResponse(u_result, status=status.HTTP_400_BAD_REQUEST)
            else:
                u_result['data'] = MatchSerializer(u_result['data']).data
                return JsonResponse(u_result)
        else:
            return HttpResponseNotModified()
    else:
        result = service.create(request, from_id)
        if result['errors']:
            return JsonResponse(result, status=status.HTTP_400_BAD_REQUEST)
        elif result['is_created']:
            result['data'] = MatchSerializer(result['data']).data
            return JsonResponse(result, status=status.HTTP_201_CREATED)
        else:
            return HttpResponseNotModified()
