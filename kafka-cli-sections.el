;;; kafka-cli-sections.el --- Summary
;;; Commentary:
;;; Code:

(defun --parse-topic (topic)
"Parse key:val to (key value) TOPIC ."
(let* ((first-output (car topic))
       (second-raw-output (cadr topic))
       (second-output (replace-regexp-in-string ": " ":" second-raw-output))
       (result '()))
  (dolist (elt (split-string first-output) result)
    (push (split-string elt ":") result))
  (dolist (elt (split-string second-output) result)
    (push (split-string elt ":") result))))

(defun --filter-topic-desc (desc)
  "DESC."
  (let ((result))
    (dolist (elt desc result)
      (if (not (equal (car elt) "Topic"))
	  (push elt result)))))

(defun insert-topic-desc-section (desc)
  "DESC ."
  (dolist (itr desc)
    (progn
      (insert " " (concat (car itr) ":" (cadr itr)))
      (add-text-properties (point-at-bol) (point) '(topic-desc t)) ;; TODO make this as a face
      (insert "\n"))))

(defun delete-topic-desc-section (desc)
  "DESC."
  (dolist (itr desc)
    (progn
      (delete-region (point-at-bol) (point-at-eol))
      (kill-line))))

(defun topic-desc-section-toggle (topic-desc-raw-output)
  "TOPIC-DESC-RAW-OUTPUT."
  (let ((desc (--filter-topic-desc (--parse-topic topic-desc-raw-output))))
    (forward-line 1)
    (setq buffer-read-only 'nil)
    (if (text-property-any (point-at-bol) (point-at-eol) 'topic-desc t)
	(delete-topic-desc-section desc)
      (insert-topic-desc-section desc))
    (setq buffer-read-only t)))

(defun goto-previous-topic ()
  "."
  (interactive)
  (let ((topic-ptr (previous-single-property-change (point) 'topic)))
    (if topic-ptr
	(progn (goto-char topic-ptr)
	       (beginning-of-line)))))

(defun goto-next-topic ()
  "."
  (interactive)
  (let ((topic-ptr (next-single-property-change (point) 'topic)))
    (if topic-ptr
	(progn (goto-char topic-ptr)
	       (beginning-of-line)))))


(provide 'kafka-cli-sections)
;;; kafka-cli-sections.el ends here