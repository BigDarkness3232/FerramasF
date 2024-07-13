from django.shortcuts import get_object_or_404,render, redirect
from .models import *
from django.core.paginator import Paginator
from django.http import Http404, HttpResponseRedirect,HttpResponse
from django.contrib.auth.decorators import login_required, user_passes_test
from .forms import *
from django.core.management.base import BaseCommand
from django.contrib import messages
from rest_framework import viewsets
from .serializers import *
import requests
from django.shortcuts import render
from django.contrib.auth.models import Group
from datetime import datetime
from dateutil.relativedelta import relativedelta
# Create your views here.


api_url = "http://127.0.0.1:5000"

#Creando una clase que va a permitir la transformacion



#Permisos
# FUNCION GENERICA QUE VALIDA EL GRUPO
#



def index(request):
    # Obtener la lista de productos desde la API
    respuesta_productos = requests.get('http://127.0.0.1:5000/Productos')
    productos = respuesta_productos.json()
    # Obtener información sobre el precio del dólar desde la API de Mindicador
    respuesta_dolar = requests.get('https://mindicador.cl/api/dolar')
    dolar_data = respuesta_dolar.json()
    precio_dolar = dolar_data['serie'][0]['valor']



    data = {
        'listaProductos': productos,
        'precioDolar': precio_dolar,
    }
    
    return render(request, 'core/index.html', data)

def registro(request):
    data = {
        'form': CreacionUsuarioForm()
    }
    if request.method == 'POST':
        formulario = CreacionUsuarioForm(data=request.POST)
        if formulario.is_valid():
            formulario.save()
            grupo_cliente = Group.objects.get(name='cliente')
            usuario = Usuario.objects.get(username=formulario.cleaned_data['username'])
            grupo_cliente.user_set.add(usuario)
            return redirect(to="index")
        data['form'] = formulario
    return render(request, 'registration/registro.html', data)



def todosAPI(request):
    respuesta = requests.get('http://127.0.0.1:8000/api/productos')
    respuesta2 = requests.get('https://mindicador.cl/api')
    productos = respuesta.json()
    monedas = respuesta2.json()
    data = {
        'listaProductos': productos,
        'moneda' : monedas,
    }
    return render(request, 'core/productos/todos_api.html', data)

#<-- Inicio Productos -->
def arbustos(request):
    productos = Producto.objects.filter(tipo_id = "1").all()
    page = request.GET.get('page', 1) # OBTENEMOS LA VARIABLE DE LA URL, SI NO EXISTE NADA DEVUELVE 1
    
    try:
        paginator = Paginator(productos, 5)
        productos = paginator.page(page)
    except:
        raise Http404

    data = {
        'listaProductos': productos,
        'paginator': paginator
    }
    return render(request, 'core/productos/Herramientas electricas.html', data)

def flores(request):
    productos = Producto.objects.filter(tipo_id = "2")
    page = request.GET.get('page', 1) # OBTENEMOS LA VARIABLE DE LA URL, SI NO EXISTE NADA DEVUELVE 1
    
    try:
        paginator = Paginator(productos, 5)
        productos = paginator.page(page)
    except:
        raise Http404

    data = {
        'listaProductos': productos,
        'paginator': paginator
    }
    return render(request, 'core/productos/Maquinas de soldar.html', data)

def sustratos(request):
    productos = Producto.objects.filter(tipo_id = "3")
    page = request.GET.get('page', 1) # OBTENEMOS LA VARIABLE DE LA URL, SI NO EXISTE NADA DEVUELVE 1
    
    try:
        paginator = Paginator(productos, 5)
        productos = paginator.page(page)
    except:
        raise Http404

    data = {
        'listaProductos': productos,
        'paginator': paginator
    }
    return render(request, 'core/productos/Herramientas generales.html', data)

def macetas(request):
    productos = Producto.objects.filter(tipo_id = "4")
    page = request.GET.get('page', 1) # OBTENEMOS LA VARIABLE DE LA URL, SI NO EXISTE NADA DEVUELVE 1

    try:
        paginator = Paginator(productos, 5)
        productos = paginator.page(page)
    except:
        raise Http404

    data1 = {

        'listaProductos': productos,
        'paginator': paginator
    }
    return render(request, 'core/productos/Clavos y tornillos.html', data1)

def herramientas(request):
    productos = Producto.objects.filter(tipo_id = "5").all()
    page = request.GET.get('page', 1) # OBTENEMOS LA VARIABLE DE LA URL, SI NO EXISTE NADA DEVUELVE 1
    
    try:
        paginator = Paginator(productos, 5)
        productos = paginator.page(page)
    except:
        raise Http404

    data = {
        'listaProductos': productos,
        'paginator': paginator
    }
    return render(request, 'core/productos/Productos de limpiezas.html', data)

#<-- Fin Productos -->

#Subscripción
def fundacion(request):
    data = {
        'form': FormularioDonacion()
    }
    if request.method == 'POST':
        formulario = FormularioDonacion(data=request.POST)
        if formulario.is_valid():
            #print("Super print debuggeador")
            #si por algun motivo el usuario vuelve apretar el boton de donar, pero no completo la donacion
            #el monto anterior se borrara
            if Donacion.objects.filter(id_usuario_id = request.user.id).exists():
                Donacion.objects.filter(id_usuario_id = request.user.id).delete()
            
            Donacion.objects.create(id_usuario_id = request.user.id, monto_a_donar = formulario.cleaned_data['monto_a_donar'])
            return redirect(to="subscripcion")
        
        data['form'] = formulario

    return render(request, 'core/fundacion.html', data)


def subscripcion(request):
    json_dolar = requests.get('https://mindicador.cl/api/dolar')
    monedas = json_dolar.json()
    valor_usd = monedas['serie'][0]['valor']

    if Donacion.objects.filter(id_usuario_id = request.user.id).exists() == False:
        return redirect(to="fundacion")       
    
    monto = Donacion.objects.get(id_usuario_id = request.user.id)
    donacion_usd = round(monto.monto_a_donar/valor_usd, 2)
    data = {
        'donacion': monto,
        'donacion_usd': donacion_usd,
    }

    return render(request, 'core/subscripcion.html', data)

def agregar_sub(request):
    if Suscripcion.objects.filter(id_usuario = request.user.id).exists():
        print("hola")
        sub = Suscripcion.objects.filter(id_usuario = request.user.id).first()
        sub.suscrito_el = datetime.now().date()
        prox_mes = sub.renovacion_el + relativedelta(months=1)
        sub.renovacion_el = prox_mes
        sub.save()
        return redirect(to="perfil")
    
    prox_mes = datetime.now().date() + relativedelta(months=1)
    Suscripcion.objects.create(id_usuario_id = request.user.id, suscrito_el = datetime.now().date(), renovacion_el = prox_mes)

    return redirect(to="perfil")
#Fin cosas subs

def perfil(request):
    if Suscripcion.objects.filter(id_usuario = request.user.id).exists():
        sub = Suscripcion.objects.filter(id_usuario = request.user.id).first()
    else:
        sub = False
    data = {
        'sub': sub,
    }
    return render(request, 'core/perfil.html', data)



#Admin CRUD
def menuadmin(request):
    respuesta = requests.get('http://127.0.0.1:5000/Productos')
    producto= respuesta.json()


    page = request.GET.get('page', 1) # OBTENEMOS LA VARIABLE DE LA URL, SI NO EXISTE NADA DEVUELVE 1
    
    try:
        paginator = Paginator(producto, 7)
        producto = paginator.page(page)
    except:
        raise Http404

    data = {
        'listaProductos': producto,
        'paginator': paginator
    }

    return render(request, 'core/crud/menuadmin.html', data)


def agregar(request):
    data = {
        'form': ProductoForm()
    }
    if request.method == 'POST':
        formulario = ProductoForm(request.POST, files=request.FILES)
        if formulario.is_valid():
            formulario.save()
            messages.success(request, "Producto almacenado correctamente")

    return render(request, 'core/crud/agregar.html', data)


def modificar(request, id):
    producto = Producto.objects.get(id=id); 
    data = {
        'form': ProductoForm(instance=producto) # LA INFO SE ALMACENA EN EL FORMULARIO
    }
    if request.method == 'POST':
        formulario = ProductoForm(data=request.POST, instance=producto, files=request.FILES)
        if formulario.is_valid():
            formulario.save()
            messages.success(request, "Producto modificado correctamente")
            data['form'] = formulario # CARGAMOS EL FORMULARIO FINAL CON LA INFO MODIFICADA

    return render(request, 'core/crud/modificar.html', data)


def eliminar(request, id):
    producto = Producto.objects.get(id=id); # OBTENEMOS UN PRODUCTO
    producto.delete()

    return redirect(to="menuadmin")


#Fin cosas del menu admin



# CRUD de los mensajes
def menumensajes(request):
    productos = Mensaje.objects.all()
    page = request.GET.get('page', 1) # OBTENEMOS LA VARIABLE DE LA URL, SI NO EXISTE NADA DEVUELVE 1
    
    try:
        paginator = Paginator(productos, 7)
        productos = paginator.page(page)
    except:
        raise Http404

    data = {
        'listaProductos': productos,
        'paginator': paginator
    }

    return render(request, 'core/crudmensajes/menumensajes.html', data)

def agregarm(request):
    data = {
        'form': MensajeForm()
    }
    if request.method == 'POST':
        formulariom = MensajeForm(request.POST, files=request.FILES)
        if formulariom.is_valid():
            formulariom.save()
            messages.success(request, "mensaje almacenado correctamente")

    return render(request, 'core/crudmensajes/agregarm.html', data)

def modificarm(request, id):
    producto = Mensaje.objects.get(id=id); 
    data = {
        'form': MensajeForm(instance=producto) # LA INFO SE ALMACENA EN EL FORMULARIO
    }
    if request.method == 'POST':
        formulario = MensajeForm(data=request.POST, instance=producto, files=request.FILES)
        if formulario.is_valid():
            formulario.save()
            messages.success(request, "Producto modificado correctamente")
            data['form'] = formulario # CARGAMOS EL FORMULARIO FINAL CON LA INFO MODIFICADA

    return render(request, 'core/crudmensajes/modificarm.html', data)

def eliminarm(request, id):
    producto = Mensaje.objects.get(id=id); # OBTENEMOS UN PRODUCTO
    producto.delete()

    return redirect(to="menumensajes")



#Fin cosas del menu mensajes

#carro


def carrito(request):
    respuesta2 = requests.get('https://mindicador.cl/api/dolar')
    monedas = respuesta2.json()
    productos = Carrito.objects.filter(id_usuario = request.user.id).all()

    if Suscripcion.objects.filter(id_usuario = request.user.id).exists():
        sub = Suscripcion.objects.filter(id_usuario = request.user.id).first()
        esta_suscrito = sub.estado_sub
    else:
        esta_suscrito = False

    precio_clp = 0
    for producto in productos:
        precio_clp = precio_clp + producto.subtotal_producto

    descuento = round(precio_clp * 0.95)

    valor_usd = monedas['serie'][0]['valor']
    if esta_suscrito == True:
        precio_usd = descuento/valor_usd
    else:
        precio_usd = precio_clp/valor_usd


    data = {
        'listaProductos': productos,
        'valor' : round(precio_usd, 2),
        'precio_clp': precio_clp,
        'descuento' : descuento,
        'is_sub' : esta_suscrito
    }

    return render(request, 'core/carrito.html', data)

def car_agregar(request, id):
    producto = get_object_or_404(Producto, id=id)
    print(f"Código del producto: {id}")
    print(f"Producto encontrado: {producto.nombre_producto}")

    usuario = request.user

    carrito, created = Carrito.objects.get_or_create(id_usuario=usuario, producto_carrito=producto)
    
    # Verifica que no se puedan agregar cantidades mayores al stock
    if producto.stock == 0:
        messages.error(request, 'No hay stock disponible para este producto')
        return redirect(request.META.get('HTTP_REFERER'))

    if not created:
        if carrito.cantidad_prod >= producto.stock:
            messages.error(request, 'No se puede agregar más de este producto al carrito')
            return redirect(request.META.get('HTTP_REFERER'))
        carrito.cantidad_prod += 1
    else:
        carrito.cantidad_prod = 1
    
    producto_restar_stock(id, 1)
    carrito.save()
    messages.success(request, 'Producto agregado')
    return redirect(request.META.get('HTTP_REFERER'))

def car_una_cantidad_menos(request, id):
    carrito = Carrito.objects.filter(id_usuario = request.user.id).filter(producto_carrito = id).first()
    if carrito.cantidad_prod == 1:
        return HttpResponseRedirect(request.META.get('HTTP_REFERER'))

    producto_sumar_stock(id, 1)
    carrito.cantidad_prod = carrito.cantidad_prod - 1
    carrito.save()

    return HttpResponseRedirect(request.META.get('HTTP_REFERER'))

def producto_restar_stock(id, arestar):
    producto = Producto.objects.filter(id = id).first()
    producto.stock = producto.stock - arestar
    producto.save()



def producto_sumar_stock(id, cantidad):
    producto = Producto.objects.filter(id = id).first()
    producto.stock = producto.stock + cantidad
    producto.save()

def car_eliminar(request, id):
    producto = Carrito.objects.filter(id_usuario = request.user.id, producto_carrito = id).first()
    producto_sumar_stock(id, producto.cantidad_prod)
    producto.delete()
    return redirect(to="carrito")

def car_eliminar_todo(request):
    carrito = Carrito.objects.filter(id_usuario = request.user.id)
    for i in carrito:
        producto_sumar_stock(i.producto_carrito.pk, i.cantidad_prod)
    carrito.delete()
    return redirect(to="carrito")

#orden

def checkout(request):
    respuesta2 = requests.get('https://mindicador.cl/api/dolar')
    monedas = respuesta2.json()
    productos = Carrito.objects.get(usuario = request.user)

    if Suscripcion.objects.filter(usuario = request.user.id).exists():
        sub = Suscripcion.objects.filter(usuario = request.user.id).first()
        esta_suscrito = sub.estado_sub
    else:
        esta_suscrito = False
    
    precio_clp = 0
    for producto in productos:
        precio_clp = precio_clp + producto.subtotal_producto
    
    descuento = round(precio_clp * 0.95)

    valor_usd = monedas['serie'][0]['valor']
    if esta_suscrito == True:
        precio_usd = descuento/valor_usd
    else:
        precio_usd = precio_clp/valor_usd

    data = {
        'listaProductos': productos,
        'valor' : round(precio_usd, 2),
        'precio_clp': precio_clp,
        'descuento' : descuento,
        'is_sub' : esta_suscrito,
        'valor_dolar': valor_usd,
    }
    
    return render(request, 'core/checkout.html', data)


def nuevo_pedido(request):
    #carrito y todo lo que contiene del usuario
    productos_carrito = Carrito.objects.filter(id_usuario = request.user.id).all()
    #nueva orden
    estado1 = EstadoOrden.objects.filter(id = 1).first()
    orden = Orden.objects.create(id_usuario = request.user, estado_orden = estado1, creado_en = datetime.now().date(), modificado_en = datetime.now().date(), direccion_envio=request.user.direccion)
    #falta precio
    total = 0
    for producto in productos_carrito:
        detalle_orden = OrdenProducto.objects.create(orden = orden, producto = producto.producto_carrito, cantidad_prod = producto.cantidad_prod)
        total = total +  producto.subtotal_producto
    
    if Suscripcion.objects.filter(id_usuario = request.user.id).exists():
        sub = Suscripcion.objects.filter(id_usuario = request.user.id).first()
        esta_suscrito = sub.estado_sub
    else:
        esta_suscrito = False
    
    if esta_suscrito:
        total = total * 0.95
        orden.descuento_sub = 1
    else:
        orden.descuento_sub = 0

    orden.precio_orden = total

    orden.save()
    detalle_orden.save()
    #Lets goooooooooo
    #Despues de creada la orden, se borra el carrito de compras
    productos_carrito.delete()
    return redirect(to="pedidos")


def pedidos(request):

    ordenes = Orden.objects.filter(id_usuario = request.user.id).all()
    page = request.GET.get('page', 1) # OBTENEMOS LA VARIABLE DE LA URL, SI NO EXISTE NADA DEVUELVE 1
    
    try:
        paginator = Paginator(ordenes, 5)
        ordenes = paginator.page(page)
    except:
        raise Http404

    data = {
        'listaPedidos': ordenes,
        'paginator': paginator
    }

    return render(request, 'core/pedidos.html', data)


def detalle_pedido(request, id):
    
    orden = Orden.objects.get(id = id)
    detalle_orden = OrdenProducto.objects.filter(orden = id).all()
    sin_descuento = round(orden.precio_orden / 0.95)
    data = {
        'orden': orden,
        'detalle': detalle_orden,
        'sin_descuento': sin_descuento
    }
    return render(request, 'core/detalle_pedido.html', data)

def menupedidos(request):
    pedidos = Orden.objects.all()
    page = request.GET.get('page', 1) # OBTENEMOS LA VARIABLE DE LA URL, SI NO EXISTE NADA DEVUELVE 1
    
    try:
        paginator = Paginator(pedidos, 7)
        pedidos = paginator.page(page)
    except:
        raise Http404

    data = {
        'listaPedidos': pedidos,
        'paginator': paginator,
        'form': EstadoOdenForm
    }
    print(data['listaPedidos'])
    return render(request, 'core/crud/menupedidos.html', data)

def actualizar_pedido(request, id):
    pedido = Orden.objects.get(id=id); 
    data = {
        'aux': pedido,
        'form': EstadoOdenForm(instance=pedido) # LA INFO SE ALMACENA EN EL FORMULARIO
    }
    if request.method == 'POST':
        formulario = EstadoOdenForm(data=request.POST, instance=pedido)
        if formulario.is_valid():
            pedido.modificado_en = datetime.now().date()
            pedido.save()
            formulario.save()
            messages.success(request, "Orden actualizado correctamente")
            data['form'] = formulario # CARGAMOS EL FORMULARIO FINAL CON LA INFO MODIFICADA

    return render(request, 'core/crud/actualizar_pedido.html', data)

def informes(request):
    pedidos = Orden.objects.all()

    data = {

        'listaPedidos': pedidos

    }
    print(data['listaPedidos'])
    return render(request, 'core/informes.html', data)

