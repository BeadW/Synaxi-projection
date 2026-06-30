Feature: APPS/interview/51 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      В Берляндском государственном университете локальная сеть между серверами не всегда работает без ошибок. При передаче двух одинаковых сообщений подряд возможна ошибка, в результате которой эти два сообщения сливаются в одно. При таком слиянии конец первого сообщения совмещается с началом второго. Конечно, совмещение может происходить только по одинаковым символам. Длина совмещения должна быть положительным числом, меньшим длины текста сообщения. 

      Например, при передаче двух сообщений «abrakadabra» подряд возможно, что оно будет передано с ошибкой описанного вида, и тогда будет получено сообщение вида «abrakadabrabrakadabra» или «abrakadabrakadabra» (в первом случае совмещение произошло по одному символу, а во втором — по четырем).

      По полученному сообщению t определите, возможно ли, что это результат ошибки описанного вида работы локальной сети, и если возможно, определите возможное значение s. 

      Не следует считать ошибкой ситуацию полного наложения друга на друга двух сообщений. К примеру, если получено сообщение «abcd», следует считать, что в нём ошибки нет. Аналогично, простое дописывание одного сообщения вслед за другим не является признаком ошибки. Например, если получено сообщение «abcabc», следует считать, что в нём ошибки нет.


      -----Входные данные-----

      В единственной строке выходных данных следует непустая строка t, состоящая из строчных букв латинского алфавита. Длина строки t не превосходит 100 символов.


      -----Выходные данные-----

      Если сообщение t не может содержать ошибки, выведите «NO» (без кавычек) в единственную строку выходных данных.

      В противном случае в первой строке выведите «YES» (без кавычек), а в следующей строке выведите строку s — возможное сообщение, которое могло привести к ошибке. Если возможных ответов несколько, разрешается вывести любой из них.


      -----Примеры-----
      Входные данные
      abrakadabrabrakadabra

      Выходные данные
      YES
      abrakadabra

      Входные данные
      acacacaca

      Выходные данные
      YES
      acaca

      Входные данные
      abcabc

      Выходные данные
      NO

      Вхо
      ...(truncated)

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "abrakadabrabrakadabra\n",
              "YES\nabrakadabra\n"
          ],
          [
              "acacacaca\n",
              "YES\nacaca\n"
          ],
          [
              "abcabc\n",
              "NO\n"
          ],
          [
              "abababab\n",
              "YES\nababab\n"
          ],
          [
              "tatbt\n",
              "NO\n"
          ]
      ]


      def test_apps():
          for i, (inp, expected) in enumerate(TEST_CASES):
              r = subprocess.run(
                  [sys.executable, "solution.py"],
                  input=inp,
                  capture_output=True,
                  text=True,
                  timeout=10,
              )
              assert r.returncode == 0, f"Case {i}: runtime error\n{r.stderr[:400]}"
              assert r.stdout.strip() == str(expected).strip(), (
                  f"Case {i}: expected {expected!r}, got {r.stdout!r}"
              )

      """

  Scenario: Agent solves the APPS problem so all tests pass
    Given an agent is tasked with reading problem.txt and implementing solution.py to read from stdin and write the correct answer to stdout so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
