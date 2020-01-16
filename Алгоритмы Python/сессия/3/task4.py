"""
(15 баллов) Имеется строка, состоящая из целых чисел, перечисленных через запятую.
Напишите функцию, которая вычисляет количество положительных и отрицательных чисел в этой строке.
Строка является параметром функции. Функция возвращает кортеж из 2 вычисленных значений.
(5 баллов) Создайте с помощью присваивания строку указанного вида.
Вызовите созданную функцию и выведите на экран полученный результат. 
(10 баллов) Выведите на экран отрицательные числа исходной строки в порядке
возрастания через запятую в одной строке.
(10 баллов) Если параметр функции не является строкой, то функция генерирует собственное исключение.
Добавьте в программу обработку исключений (как собственного, так и стандартных).
"""


from collections import defaultdict


def get_values(input_str):
    input_list = input_str.split(",")

    new_dict = defaultdict(int)

    # Цикл по каждому элементу
    for e in input_list:

        # Если элемент меньше нуля, то увеличиваем количество отрицательных чисел на 1
        if int(e) < 0:
            new_dict["minus"] += 1

        # Если элемент больше нуля, то увеличиваем количество положительных чисел на 1
        elif int(e) > 0:
            new_dict["plus"] -= 1

    # Возврат значения
    return new_dict["plus"], new_dict["minus"]


if __name__ == "__main__":
    # Исходная строка
    this_str = "1,-1,2,35,-56,305,-35,-2"

    # Результат
    try:
        result = get_values(this_str)
        print("Результат:", result)

    except ValueError as e:
        print(e)
    except Exception as e:
        print("Неожиданная ошибка:", e)

    # Перевод в list с разделителем по ,
    this_list = this_str.split(",")

    # Выходной список
    out_list = []

    # Цикл по каждому элементу списка
    for e in this_list:
        # Если элемент меньше нуля, то добавляем в новый список
        if int(e) < 0:
            out_list.append(int(e))

    # Сортируем новый список
    out_list.sort()

    # Переводим каждый элемент словаря out_list в строковый тип
    out_list = [str(x) for x in out_list]

    # Выводим каждый элемент из словаря out_list на экран
    print(" ".join(out_list))
