
;1.9 Каждая из двух приведенных процедур реализует сложение в терминах инкремента (int),
; используя модель замещения, проиллюстрируйте процесс вычисления, это рекурсивные или
; итеративные процессы?

(define (inc x) (+ x 1))
(define (dec x) (- x 1))

(define (|| a b)
  (if(<= a 0)
    b
  (inc (|| (dec a) b)))); => Представляет линейно-рекурсивный процесс.
  ; Пояснение: Потому что основная процедура (||) будет самовызываться до inc,
  ; тем самым откладывая факт инкрементации.

  (define (| a b)
  (if (<= a 0)
    b
  (| (dec a) (inc b)))); => Представляет линейно-итеративный процесс.


(| 5 2)
(|| 5 3)


;(Прим.) 
; 1. Если дать имя +, помимо того, что две процедуры 
; будут конфликтовать между собой, они еще
; будут уходить в бесконечную рекурсию/итерацию из-за использования аналогичного символа в inc.
; 2. Названия процедур "|"" и "||"" были выбраны по аналогии с логичским +, по типу того,
; как дизъюнкция часто представленна в языках программирования. 

;1.10 Функция Аккермана. Интересна тем что являетеся рекурсивной и растет быстрее экспоненты.

(define (A x y)
  (cond ((= y 0) 0)
	((= x 0) (* 2 y))
	((= y 1) 2)
	(else (A (- x 1)
		 (A x (- y 1))))))
(A 1 10) ; => 1024 или 2^10
(A 2 4) ; => 65536 или 2^16
(A 3 3) ; => 65536 или 2^16

; Дайте краткое математическое определение функций f, g и h 
; для положительных целых значений n. К примеру k(n) = 5*n*n

(define (f n) (A 0 n)); => 2n
(f 10); => 20
(define (g n) (A 1 n)); => 2^n
(g 8); => 256
(define (h n) (A 2 n 1)); => 2^(2^(n - 1)) для n > 2
(h 5); => +inf.0 или 2^65536
(define (k n) (* 5 n n)); => 5n^2 



;1.11 Функция f(n) = n, если n<3 и f(n) = f(n - 1) + f(n - 2) + f(n - 3) если n>= 3. ;
; Напишите процедуру для вычисления значения f в рекурсивной и итеративной форме.


(define (fr n) (
  if(< n 3) 
    n
  (+ (fr (- n 1))
     (fr (- n 2))
     (fr (- n 3))
  )
))


(define (f n)
  (f-iter 0 1 2 n))

(define (f-iter a b acc n) (
  if (< n 3)
	    acc
	(f-iter 
    b
    acc
    (+ acc b a)
    (- n 1))
)); Версия выполнена па аналогии примера из учебника.
;Взял подсказку.

; (fr 6)
(f 6)

; Данное упражнение иллюстрирует насколько просто и декларативно можно выразить
; некоторые задачи через рекурсивный процесс.