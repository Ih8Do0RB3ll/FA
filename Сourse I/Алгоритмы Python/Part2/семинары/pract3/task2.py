"""
2. Дано натуральное число N. Выведите слово YES, если число N является точной степенью
двойки, или слово NO в противном случае. Операцией возведения в степень пользоваться
нельзя!
Ввод: 8
Вывод: Yes
Ввод: 3
Вывод: No
"""
import math
def r_checker(n,i=1):
    if i > n:
        print("NO")
        return

    if i == n:
        print("YES")
        return

    r_checker(n, i * 2)


if __name__ == "__main__":
    n = int(input("Введите натуральное число n -> "))
    r_checker(n)