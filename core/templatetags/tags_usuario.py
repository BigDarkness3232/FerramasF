from django import template
register = template.Library()

@register.simple_tag
def es_vendedor(request):
    return request.user.groups.filter(name="vendedor").exists()

@register.simple_tag
def es_contador(request):
    return request.user.groups.filter(name="contador").exists()

@register.simple_tag
def es_bodeguero(request):
    return request.user.groups.filter(name="bodeguero").exists()

