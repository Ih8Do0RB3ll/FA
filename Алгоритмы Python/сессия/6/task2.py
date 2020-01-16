"""
(20 баллов) Строка представляет собой список оценок через запятую, например, «3, 4, 5, 2».
Количество оценок заранее неизвестно.
Напишите функцию, которая преобразует эту строку к виду, где оценки указаны словами: «удовлетворительно, хорошо, отлично, неудовлетворительно».
Проверьте, что оценка находится в диапазоне от 2 до 5.
Недопустимая оценка заменяется словом «ошибка». Функция возвращает полученную строку.

(10 баллов) Создайте с помощью присваивания список вида [«Иванов: 4, 4, 3», «Петров: 2, 5»].
Используя созданную функцию, преобразуйте его к виду [«Иванов: хорошо, хорошо, удовлетворительно», «Петров: неудовлетворительно, отлично»].
"""


def converter(input_str):
    # Словарь с транслитом элементов
    locale_dict = {
        "2": "неудовлетворительно",
        "3": "удовлетворительно",
        "4": "хорошо",
        "5": "отлично",
    }

    return ", ".join(
        locale_dict[e] if 5 >= int(e) >= 2 else "ошибка" for e in input_str.split(", ")
    )


if __name__ == "__main__":

    # Исходный и он же результирующий список
    global_list = ["Иванов: 4, 4, 3", "Петров: 2, 5"]
    # Результирующий список
    result_list = []

    # Цикл по каждому элементу
    for i in range(len(global_list)):
        # Разделение по :
        name, values = global_list[i].split(": ")
        # Получение результатов от функции
        result = converter(values)

        # Присваиваем новое значение-результат по индексу i
        global_list[i] = name + ": " + result

    # Выводим результирующий список на экран
    print(global_list)
