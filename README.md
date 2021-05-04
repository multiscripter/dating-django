[![Build Status](https://travis-ci.com/multiscripter/dating-django.svg?branch=master)](https://travis-ci.com/multiscripter/dating-django)
[![codecov](https://codecov.io/gh/multiscripter/dating-django/branch/master/graph/badge.svg?token=SN2RIT4DJH)](https://codecov.io/gh/multiscripter/dating-django)

**Тестовое задание:**
```
Общая идея: пишем бекэнд для сайта (приложения) знакомств.

Основное задание (Junior):
1. Создать модель участников. 
У участника должна быть аватарка, пол, имя и фамилия, почта.
2. Создать эндпоинт регистрации нового участника: /api/clients/create 
(не забываем о пароле и совместимости с авторизацией модели участника).
3. При регистрации нового участника необходимо обработать его аватарку: 
наложить на него водяной знак (в качестве водяного знака можете взять любую картинку).
4. Создать эндпоинт оценивания участником другого участника: /api/clients/<id>/match. 
В случае, если возникает взаимная симпатия, то ответом выдаем почту клиенту 
и отправляем на почты участников: «Вы понравились <имя>! Почта участника: <почта>».
5. Создать эндпоинт списка участников: /api/list. 
Должна быть возможность фильтрации листа по полу, имени, фамилии. 
Советую использовать библиотеку Django-filters.

Задания повышенной сложности (Middle):
1. Реализовать определение дистанции между участниками. 
Добавить поля долготы и широты. В api списка добавить дополнительный фильтр, 
который бы показывал участников в пределах заданной дистанции. 
https://en.wikipedia.org/wiki/Great-circle_distance
2. Подключить чаты (channels).

Дополнительные задания (чем больше сделаете, тем лучше):
1. Создать модуль транзакций и подключить эквайринг Сбербанка.
2. Написать юнит-тесты для системы.
3. Распарсить любой сайт знакомств или социальную сеть на участников 
и перенести их к себе в базу. Использование прокси приветствуется.
```
каркас: **Django 3.2**

база данных: **PostgreSQL 13.2**

тесты: **unittest, pytest**

**Запуск из корня проекта:**
```
docker-compose build
docker-compose up -d
python manage.py runserver
```
**Запуск:**
```
http://127.0.0.1:8000/
```