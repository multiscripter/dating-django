from django.http import HttpResponse, HttpResponseNotAllowed, JsonResponse, HttpResponseNotModified

from dating.models.Client import Client
from dating.models.Match import Match


def create(request):
    if request.method == 'POST':
        client = Client(**request.POST)
        client.first_name = request.POST['first_name']
        client.last_name = request.POST['last_name']
        client.email = request.POST['email']
        client.gender = Client.Gender(request.POST['gender'])
        client.avatar = request.FILES['avatar']
        client.save()
        return HttpResponse(status=201)
    else:
        return HttpResponseNotAllowed([request.method])


def create_match(request, from_id):
    if request.method == 'POST':
        matches = Match.objects.filter(
            to_id=from_id, from_id=request.POST['id']
        )
        if len(matches):
            if not matches[0].is_mutually:
                matches[0].is_mutually = True
                matches[0].save()
                # TODO: отправить уведомления по почте обоим о совпадении.
                # TODO: Вы понравились <имя>! Почта участника: <почта>
                return HttpResponse()
            else:
                return HttpResponseNotModified()
        else:
            match, created = Match.objects.get_or_create(
                from_id=Client.objects.get(id=from_id),
                to_id=Client.objects.get(id=request.POST['id'])
            )
            if created:
                return HttpResponse(status=201)
            else:
                return HttpResponseNotModified()
    else:
        return HttpResponseNotAllowed([request.method])


def get_list(request):
    if request.method == 'GET':
        data = {
            'clients': []
        }
        clients = Client.objects
        for field in ['first_name', 'last_name', 'gender']:
            if field in request.GET:
                name = field + '__iexact'
                f = {name: request.GET[field]}
                clients = clients.filter(**f)
        clients = clients.all()
        if len(clients):
            for c in clients:
                data['clients'].append(c.to_dict())

        return JsonResponse(data)
    else:
        return HttpResponseNotAllowed([request.method])
