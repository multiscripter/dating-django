from django.http import HttpResponse, JsonResponse
from django.http import HttpResponseNotModified
from django.http import HttpResponseNotAllowed

from dating.models.Client import Client
from dating.models.Match import Match
from dating.services.MatchService import MatchService


def create(request, from_id):
    if request.method == 'POST':
        # TODO: add POST data validation.
        service = MatchService()
        params = {'to_id': from_id, 'from_id': request.POST['id']}
        result = service.read(params)
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
            params = {
                'from_id': Client.objects.get(id=from_id),
                'to_id': Client.objects.get(id=request.POST['id'])
            }
            result = service.create(params)
            if result['errors']:
                return JsonResponse(result, status=400)
            elif result['is_created']:
                result['data'] = result['data'].to_dict()
                return JsonResponse(result, status=201)
            else:
                return HttpResponseNotModified()
    else:
        return HttpResponseNotAllowed(['POST'])
