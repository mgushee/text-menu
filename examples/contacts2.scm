(use text-menu)

(interact
  (steps
    (first: (make-step 'first))
    (last: (make-step 'last))
    (phone: (make-step 'phone required: #f))
    (email: (make-step 'email))
    (lastcon: (make-date-step 'last-contact))
    (bd: (make-date-step 'birthday default-year-rule: 'none default-month-rule: 'none)))
  looping: #t)

(define (print-csv row)
  (let loop ((fields '(first last phone email last-contact birthday)))
    (let* ((this-field (car fields))
           (rest (cdr fields))
           (field-data (or (alist-ref this-field row) "")))
      (display field-data)
      (if (null? rest)
        (newline)
        (begin
          (display ",") (loop rest))))))

(let ((data (get-all-data)))
  (let loop ((row (queue-remove! data)))
    (print-csv (queue->list row))
    (if (queue-empty? data)
      #f
      (loop (queue-remove! data)))))
