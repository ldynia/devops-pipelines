import json

from django.http import HttpResponse


def foo(request):
    data = {'hello': 'foo'}
    jd = json.dumps(data)

    return HttpResponse(jd, content_type="application/json")


def bar(request):
    data = {'hello': 'bar'}
    jd = json.dumps(data)

    return HttpResponse(jd, content_type="application/json")