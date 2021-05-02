from django.http import HttpResponseNotAllowed
from django.http import HttpResponseNotModified
from django.http import JsonResponse

from dating.services.MatchService import MatchService


def create(request, from_id):
    if request.method == 'POST':
        # TODO: add POST data validation.
        service = MatchService()
        result = service.read(request, from_id)
        if len(result['data']):
            if not result['data'][0].is_mutually:
                u_result = service.update(
                    result['data'][0], {'is_mutually': True}
                )
                if u_result['errors']:
                    return JsonResponse(u_result, status=400)
                else:
                    u_result['data'] = u_result['data'].to_dict()
                    return JsonResponse(u_result)
            else:
                return HttpResponseNotModified()
        else:
            result = service.create(request, from_id)
            if result['errors']:
                return JsonResponse(result, status=400)
            elif result['is_created']:
                result['data'] = result['data'].to_dict()
                return JsonResponse(result, status=201)
            else:
                return HttpResponseNotModified()
    else:
        return HttpResponseNotAllowed(['POST'])
