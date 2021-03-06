;; Tests which don't fit anywhere else

(ert-deftest sp-test-sp-point-in-symbol-at-the-eob ()
  "When the point is `eobp' it should not be in symbol."
  (sp-test-with-temp-elisp-buffer "foo-bar|"
    (should (not (sp-point-in-symbol)))))

(ert-deftest sp-test-sp-point-in-symbol-inside-symbol ()
  "When the point is inside symbol it should be in symbol."
  (sp-test-with-temp-elisp-buffer "foo-|bar"
    (should (sp-point-in-symbol)))
  (sp-test-with-temp-elisp-buffer "foo-b|ar"
    (should (sp-point-in-symbol))))

;; #634
(ert-deftest sp-test-sp-skip-backward-to-symbol-sexp-at-the-end-of-comment ()
  "When we are skipping backward and land on a sexp delimiter
right at the end of comment, and we started outside a comment, we
should skip the current comment instead of ending on the
delimiter."
  (sp-test-with-temp-elisp-buffer "foo\n;; (bar)\n|baz"
    (sp-skip-backward-to-symbol)
    (insert "|")
    (should (equal (buffer-string) "foo|\n;; (bar)\nbaz")))

  (sp-test-with-temp-elisp-buffer "foo\n;; \"bar\"\n|baz"
    (sp-skip-backward-to-symbol)
    (insert "|")
    (should (equal (buffer-string) "foo|\n;; \"bar\"\nbaz"))))
