from django.http import HttpResponseNotAllowed
from django.http import JsonResponse

from dating.services.ClientService import ClientService


def create(request):
    if request.method == 'POST':
        # TODO: add POST data validation.
        service = ClientService()
        result = service.create(request)
        if result['errors']:
            return JsonResponse(result, status=400)
        else:
            result['data'] = result['data'].to_dict()
            return JsonResponse(result, status=201)
    else:
        return HttpResponseNotAllowed(['POST'])


def get_list(request):
    if request.method == 'GET':
        # TODO: add POST data validation.
        service = ClientService()
        result = service.read(request)
        if result['errors']:
            return JsonResponse(result, status=400)
        else:
            return JsonResponse(result)
    else:
        return HttpResponseNotAllowed(['GET'])
