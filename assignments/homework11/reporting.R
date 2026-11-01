# reporting.R
# ------------------------------------------------------------
# Model summary tables for R Markdown (HTML)
# - Accessible tables: captions + column headers + row headers (scope="row")
# - Clean presentation: readable variable labels, formatted p-values
# - Works with lm() and glm() (including logistic with odds ratios)
#
# Usage in .Rmd:
#   source("reporting.R")
#   m1 <- lm(y ~ x1 + x2, data = df)
#   mk_coeftab(m1, mode = "simple",
#              term_labels = c(x1 = "Hours studied", x2 = "Tutoring (yes=1)"),
#              caption = "Model: Final grade on study hours and tutoring")
#
# Note: In the chunk that prints a table, set results='asis':
#   ```{r, results='asis'}
#   mk_coeftab(m1, ...)
#   ```
# ------------------------------------------------------------

# ---- Internal: convert first column body cells to row headers (<th scope="row">) ----

.make_first_col_rowheaders <- function(k_html) {
  attrs <- attributes(k_html)
  x <- as.character(k_html)
  
  # Convert the first <td ...> after each <tr ...> into <th scope="row" ...>
  # Also force left alignment so lightable CSS doesn't center th's.
  x <- gsub(
    pattern = "(<tr[^>]*>\\s*)<td([^>]*)>",
    replacement = "\\1<th scope=\"row\"\\2 style=\"text-align:left;\">",
    x,
    perl = TRUE
  )
  
  # Convert the corresponding first </td> in each row into </th>
  x <- gsub(
    pattern = "(<tr[^>]*>\\s*<th scope=\"row\"[^>]*>.*?)(</td>)",
    replacement = "\\1</th>",
    x,
    perl = TRUE
  )
  
  attributes(x) <- attrs
  x
}

.add_col_scope <- function(k_html) {
  attrs <- attributes(k_html)
  x <- as.character(k_html)
  
  # Add scope="col" to any thead <th> that doesn't already have scope
  x <- gsub(
    "(<thead[^>]*>.*?<th)(?![^>]*\\bscope=)([^>]*>)",
    "\\1 scope=\"col\"\\2",
    x,
    perl = TRUE
  )
  
  attributes(x) <- attrs
  x
}


# ---- Dependencies (kept minimal) ----
.require_pkg <- function(pkg) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    stop(sprintf("Package '%s' is required. Install it with install.packages('%s').", pkg, pkg),
         call. = FALSE)
  }
}

# p-value formatting that reads well in class materials
fmt_p <- function(p) {
  ifelse(is.na(p), NA_character_,
         ifelse(p < 0.001, "<0.001", sprintf("%.3f", p)))
}

# Internal: apply nice term labels if provided
.apply_term_labels <- function(terms, term_labels) {
  if (is.null(term_labels)) return(terms)
  idx <- match(terms, names(term_labels))
  out <- terms
  out[!is.na(idx)] <- unname(term_labels[idx[!is.na(idx)]])
  out
}

# Internal: (no longer emits <th>; we do row headers via .make_first_col_rowheaders)
.as_row_headers <- function(x) x

# ------------------------------------------------------------
# 1) Coefficient table for lm()/glm()
# ------------------------------------------------------------
mk_coeftab <- function(model,
                       mode = c("simple", "full"),
                       term_labels = NULL,
                       caption = "Model summary",
                       digits = 3) {
  mode <- match.arg(mode)
  
  .require_pkg("broom")
  .require_pkg("knitr")
  
  has_kableextra <- requireNamespace("kableExtra", quietly = TRUE)
  
  tb <- broom::tidy(model, conf.int = (mode == "full"))
  
  tb$term <- ifelse(tb$term == "(Intercept)", "Intercept", tb$term)
  tb$term <- .apply_term_labels(tb$term, term_labels)
  
  if (mode == "simple") {
    out <- data.frame(
      Term = tb$term,
      Estimate = round(tb$estimate, digits),
      `Std. Error` = round(tb$std.error, digits),
      `p value` = fmt_p(tb$p.value),
      check.names = FALSE
    )
  } else {
    out <- data.frame(
      Term = tb$term,
      Estimate = round(tb$estimate, digits),
      `Std. Error` = round(tb$std.error, digits),
      `t/z value` = round(tb$statistic, 2),
      `p value` = fmt_p(tb$p.value),
      `95% CI` = paste0(round(tb$conf.low, digits), " to ", round(tb$conf.high, digits)),
      check.names = FALSE
    )
  }
  
  k <- knitr::kable(
    out,
    format = "html",
    escape = TRUE,
    caption = caption,
    align = c("l", rep("r", ncol(out) - 1)),
    row.names = FALSE
  )
  
  if (has_kableextra) {
    k <- k |>
      kableExtra::kable_classic(full_width = FALSE) |>
      kableExtra::row_spec(0, bold = TRUE)
  }
  
  k <- .make_first_col_rowheaders(k)
  k
}


mk_coeftab_robust <- function(model,
                              mode = c("simple", "full"),
                              term_labels = NULL,
                              caption = "Model summary (robust SEs)",
                              digits = 3,
                              robust_type = "HC1") {
  mode <- match.arg(mode)
  
  .require_pkg("broom")
  .require_pkg("knitr")
  .require_pkg("sandwich")
  .require_pkg("lmtest")
  
  has_kableextra <- requireNamespace("kableExtra", quietly = TRUE)
  
  # Robust VCOV and robust coefficient test
  Vrob <- sandwich::vcovHC(model, type = robust_type)
  ct <- lmtest::coeftest(model, vcov. = Vrob)
  tb <- broom::tidy(ct)
  
  # Robust confidence intervals if needed
  if (mode == "full") {
    crit <- qt(0.975, df = stats::df.residual(model))
    tb$conf.low  <- tb$estimate - crit * tb$std.error
    tb$conf.high <- tb$estimate + crit * tb$std.error
  }
  
  tb$term <- ifelse(tb$term == "(Intercept)", "Intercept", tb$term)
  tb$term <- .apply_term_labels(tb$term, term_labels)
  
  if (mode == "simple") {
    out <- data.frame(
      Term = tb$term,
      Estimate = round(tb$estimate, digits),
      `Std. Error (robust)` = round(tb$std.error, digits),
      `p value` = fmt_p(tb$p.value),
      check.names = FALSE
    )
  } else {
    out <- data.frame(
      Term = tb$term,
      Estimate = round(tb$estimate, digits),
      `Std. Error (robust)` = round(tb$std.error, digits),
      `t/z value` = round(tb$statistic, 2),
      `p value` = fmt_p(tb$p.value),
      `95% CI` = paste0(round(tb$conf.low, digits), " to ", round(tb$conf.high, digits)),
      check.names = FALSE
    )
  }
  
  k <- knitr::kable(
    out,
    format = "html",
    escape = TRUE,
    caption = caption,
    align = c("l", rep("r", ncol(out) - 1)),
    row.names = FALSE
  )
  
  if (has_kableextra) {
    k <- k |>
      kableExtra::kable_classic(full_width = FALSE) |>
      kableExtra::row_spec(0, bold = TRUE)
  }
  
  k <- .make_first_col_rowheaders(k)
  k
}


# ------------------------------------------------------------
# 2) Model fit summary (for comparing models)
# ------------------------------------------------------------
mk_fit <- function(..., caption = "Model fit summary", digits = 3) {
  .require_pkg("broom")
  .require_pkg("knitr")
  has_kableextra <- requireNamespace("kableExtra", quietly = TRUE)
  
  mods <- list(...)
  nm <- names(mods)
  if (is.null(nm) || any(nm == "")) {
    nm <- paste0("Model ", seq_along(mods))
  }
  
  rows <- lapply(seq_along(mods), function(i) {
    g <- broom::glance(mods[[i]])
    data.frame(
      Model = nm[i],
      `R²` = if (!is.null(g$r.squared)) round(g$r.squared, digits) else NA_real_,
      `Adj. R²` = if (!is.null(g$adj.r.squared)) round(g$adj.r.squared, digits) else NA_real_,
      AIC = if (!is.null(g$AIC)) round(g$AIC, 1) else NA_real_,
      BIC = if (!is.null(g$BIC)) round(g$BIC, 1) else NA_real_,
      `Residual SE` = if (!is.null(g$sigma)) round(g$sigma, digits) else NA_real_,
      check.names = FALSE
    )
  })
  
  out <- do.call(rbind, rows)
  
  k <- knitr::kable(
    out,
    format = "html",
    escape = TRUE,
    caption = caption,
    align = c("l", rep("r", ncol(out) - 1)),
    row.names = FALSE
  )
  
  if (has_kableextra) {
    k <- k |>
      kableExtra::kable_classic(full_width = FALSE) |>
      kableExtra::row_spec(0, bold = TRUE)
  }
  
  k <- .make_first_col_rowheaders(k)
  k
}

# ------------------------------------------------------------
# 3) Logistic regression as odds ratios
# ------------------------------------------------------------
mk_or_table <- function(model,
                        term_labels = NULL,
                        caption = "Logistic regression (odds ratios)",
                        digits = 3) {
  .require_pkg("broom")
  .require_pkg("knitr")
  has_kableextra <- requireNamespace("kableExtra", quietly = TRUE)
  
  tb <- broom::tidy(model, conf.int = TRUE, exponentiate = TRUE)
  tb$term <- ifelse(tb$term == "(Intercept)", "Intercept", tb$term)
  tb$term <- .apply_term_labels(tb$term, term_labels)
  
  out <- data.frame(
    Term = tb$term,
    `Odds ratio` = round(tb$estimate, digits),
    `95% CI` = paste0(round(tb$conf.low, digits), " to ", round(tb$conf.high, digits)),
    `p value` = fmt_p(tb$p.value),
    check.names = FALSE
  )
  
  k <- knitr::kable(
    out,
    format = "html",
    escape = TRUE,
    caption = caption,
    align = c("l", "r", "l", "r"),
    row.names = FALSE
  )
  
  if (has_kableextra) {
    k <- k |>
      kableExtra::kable_classic(full_width = FALSE) |>
      kableExtra::row_spec(0, bold = TRUE)
  }
  
  k <- .make_first_col_rowheaders(k)
  k
}

# ------------------------------------------------------------
# 4) Variance–covariance matrix (vcov)
# ------------------------------------------------------------
mk_vcov_table <- function(model,
                          format = c("long", "matrix", "cor"),
                          term_labels = NULL,
                          caption = NULL,
                          digits = 4,
                          include_variances = TRUE) {
  format <- match.arg(format)
  
  .require_pkg("knitr")
  .require_pkg("broom")
  has_kableextra <- requireNamespace("kableExtra", quietly = TRUE)
  
  V <- stats::vcov(model)
  
  nm <- colnames(V)
  nm <- ifelse(nm == "(Intercept)", "Intercept", nm)
  nm <- .apply_term_labels(nm, term_labels)
  colnames(V) <- nm
  rownames(V) <- nm
  
  if (is.null(caption)) {
    caption <- switch(
      format,
      long   = "Variance–covariance matrix (long format)",
      matrix = "Variance–covariance matrix of coefficient estimates",
      cor    = "Correlation matrix of coefficient estimates"
    )
  }
  
  if (format == "cor") {
    V <- stats::cov2cor(V)
  }
  
  if (format == "long") {
    .require_pkg("tibble")
    .require_pkg("tidyr")
    
    df_long <- as.data.frame(round(V, digits)) |>
      tibble::rownames_to_column("Term 1") |>
      tidyr::pivot_longer(
        cols = -`Term 1`,
        names_to = "Term 2",
        values_to = if (format == "cor") "Correlation" else "Covariance"
      )
    
    if (!include_variances) {
      df_long <- df_long[df_long$`Term 1` != df_long$`Term 2`, , drop = FALSE]
    }
    
    k <- knitr::kable(
      df_long,
      format = "html",
      escape = TRUE,
      caption = caption,
      align = c("l", "l", "r"),
      row.names = FALSE
    )
    
    if (has_kableextra) {
      k <- k |>
        kableExtra::kable_classic(full_width = FALSE) |>
        kableExtra::row_spec(0, bold = TRUE)
    }
    
    k <- .make_first_col_rowheaders(k)
    return(k)
  }
  
  # matrix/cor formats
  df_mat <- as.data.frame(round(V, digits))
  df_mat$Term <- rownames(df_mat)
  df_mat <- df_mat[, c("Term", setdiff(colnames(df_mat), "Term")), drop = FALSE]
  
  k <- knitr::kable(
    df_mat,
    format = "html",
    escape = TRUE,
    caption = caption,
    align = c("l", rep("r", ncol(df_mat) - 1)),
    row.names = FALSE   # <-- critical: prevents extra blank rowname column
  )
  
  if (has_kableextra) {
    k <- k |>
      kableExtra::kable_classic(full_width = FALSE) |>
      kableExtra::row_spec(0, bold = TRUE)
  }
  
  k <- .make_first_col_rowheaders(k)
  k
}

# ------------------------------------------------------------
# 5) Robust variance–covariance tables + SE comparison
# ------------------------------------------------------------
mk_robust_vcov_table <- function(model,
                                 format = c("long", "matrix", "cor"),
                                 robust_type = c("HC1", "HC0", "HC2", "HC3", "HC4", "HC5"),
                                 term_labels = NULL,
                                 caption = NULL,
                                 digits = 4,
                                 include_variances = TRUE) {
  format <- match.arg(format)
  robust_type <- match.arg(robust_type)
  
  .require_pkg("knitr")
  .require_pkg("broom")
  .require_pkg("sandwich")
  has_kableextra <- requireNamespace("kableExtra", quietly = TRUE)
  
  V <- sandwich::vcovHC(model, type = robust_type)
  
  nm <- colnames(V)
  nm <- ifelse(nm == "(Intercept)", "Intercept", nm)
  nm <- .apply_term_labels(nm, term_labels)
  colnames(V) <- nm
  rownames(V) <- nm
  
  if (is.null(caption)) {
    caption <- switch(
      format,
      long   = paste0("Robust variance–covariance matrix (", robust_type, ", long format)"),
      matrix = paste0("Robust variance–covariance matrix (", robust_type, ")"),
      cor    = paste0("Correlation matrix of coefficient estimates (robust vcov: ", robust_type, ")")
    )
  }
  
  if (format == "cor") {
    V <- stats::cov2cor(V)
  }
  
  if (format == "long") {
    .require_pkg("tibble")
    .require_pkg("tidyr")
    
    df_long <- as.data.frame(round(V, digits)) |>
      tibble::rownames_to_column("Term 1") |>
      tidyr::pivot_longer(
        cols = -`Term 1`,
        names_to = "Term 2",
        values_to = if (format == "cor") "Correlation" else "Covariance"
      )
    
    if (!include_variances) {
      df_long <- df_long[df_long$`Term 1` != df_long$`Term 2`, , drop = FALSE]
    }
    
    k <- knitr::kable(
      df_long,
      format = "html",
      escape = TRUE,
      caption = caption,
      align = c("l", "l", "r"),
      row.names = FALSE
    )
    
    if (has_kableextra) {
      k <- k |>
        kableExtra::kable_classic(full_width = FALSE) |>
        kableExtra::row_spec(0, bold = TRUE)
    }
    
    k <- .make_first_col_rowheaders(k)
    return(k)
  }
  
  df_mat <- as.data.frame(round(V, digits))
  df_mat$Term <- rownames(df_mat)
  df_mat <- df_mat[, c("Term", setdiff(colnames(df_mat), "Term")), drop = FALSE]
  
  k <- knitr::kable(
    df_mat,
    format = "html",
    escape = TRUE,
    caption = caption,
    align = c("l", rep("r", ncol(df_mat) - 1)),
    row.names = FALSE
  )
  
  if (has_kableextra) {
    k <- k |>
      kableExtra::kable_classic(full_width = FALSE) |>
      kableExtra::row_spec(0, bold = TRUE)
  }
  
  k <- .make_first_col_rowheaders(k)
  k
}

# ------------------------------------------------------------
# Compare classical vs robust SE (and resulting test stats) in one accessible table
# ------------------------------------------------------------

mk_se_compare <- function(model,
                          robust_type = c("HC1", "HC0", "HC2", "HC3", "HC4", "HC5"),
                          term_labels = NULL,
                          caption = NULL,
                          digits = 3) {
  robust_type <- match.arg(robust_type)
  
  .require_pkg("broom")
  .require_pkg("knitr")
  .require_pkg("sandwich")
  has_kableextra <- requireNamespace("kableExtra", quietly = TRUE)
  
  t_classic <- broom::tidy(model)
  
  Vrob <- sandwich::vcovHC(model, type = robust_type)
  t_robust <- broom::tidy(model, vcov = Vrob)
  
  t <- t_classic |>
    dplyr::select(term, estimate, std.error, statistic, p.value) |>
    dplyr::rename(
      Estimate = estimate,
      `SE (classical)` = std.error,
      `t/z (classical)` = statistic,
      `p (classical)` = p.value
    ) |>
    dplyr::left_join(
      t_robust |>
        dplyr::select(term, std.error, statistic, p.value) |>
        dplyr::rename(
          `SE (robust)` = std.error,
          `t/z (robust)` = statistic,
          `p (robust)` = p.value
        ),
      by = "term"
    ) |>
    dplyr::mutate(
      term = ifelse(term == "(Intercept)", "Intercept", term),
      term = .apply_term_labels(term, term_labels),
      Estimate = round(Estimate, digits),
      `SE (classical)` = round(`SE (classical)`, digits),
      `SE (robust)` = round(`SE (robust)`, digits),
      `t/z (classical)` = round(`t/z (classical)`, 2),
      `t/z (robust)` = round(`t/z (robust)`, 2),
      `p (classical)` = fmt_p(`p (classical)`),
      `p (robust)` = fmt_p(`p (robust)`)
    )
  
  if (is.null(caption)) {
    caption <- paste0("Classical vs robust standard errors (", robust_type, ")")
  }
  
  k <- knitr::kable(
    t,
    format = "html",
    escape = TRUE,
    caption = caption,
    col.names = c(
      "Term", "Estimate",
      "SE (classical)", "t/z (classical)", "p (classical)",
      "SE (robust)", "t/z (robust)", "p (robust)"
    ),
    align = c("l", rep("r", ncol(t) - 1)),
    row.names = FALSE
  )
  
  if (has_kableextra) {
    k <- k |>
      kableExtra::kable_classic(full_width = FALSE) |>
      kableExtra::row_spec(0, bold = TRUE)
  }
  
  k <- .make_first_col_rowheaders(k)
  k
}

# ------------------------------------------------------------
# summary stats functions
# ------------------------------------------------------------

mk_factor_summary <- function(data,
                              vars = NULL,
                              digits = 1,
                              caption = "Distribution of categorical variables",
                              include_na = TRUE) {
  stopifnot(is.data.frame(data))
  
  if (is.null(vars)) {
    vars <- names(dplyr::select(data, where(is.factor)))
  } else {
    vars <- tidyselect::eval_select(rlang::enquo(vars), data) |> names()
  }
  
  if (length(vars) == 0) {
    stop("No factor variables found/selected.")
  }
  
  out <- data |>
    dplyr::select(dplyr::all_of(vars)) |>
    tidyr::pivot_longer(
      cols = dplyr::everything(),
      names_to = "Variable",
      values_to = "Category"
    )
  
  if (include_na) {
    out <- out |>
      dplyr::mutate(
        Category = forcats::fct_na_value_to_level(Category, level = "(Missing)")
      )
  } else {
    out <- out |>
      dplyr::filter(!is.na(Category))
  }
  
  k <- out |>
    dplyr::count(Variable, Category, name = "Count") |>
    dplyr::group_by(Variable) |>
    dplyr::mutate(Percent = 100 * Count / sum(Count)) |>
    dplyr::ungroup() |>
    dplyr::mutate(Percent = round(Percent, digits)) |>
    knitr::kable(
      format = "html",
      caption = caption,
      col.names = c("Variable", "Category", "Count", "Percent"),
      align = "llrr",
      escape = TRUE
    ) |>
    kableExtra::kable_styling(full_width = FALSE)
  
  # --- Accessibility fixes ---
  k <- .add_col_scope(k)
  k <- .make_first_col_rowheaders(k)  # optional but recommended
  
  k
}

mk_numeric_summary <- function(data,
                               vars = NULL,
                               digits = 2,
                               caption = "Summary statistics for numeric variables",
                               include_range = TRUE) {
  stopifnot(is.data.frame(data))
  
  if (is.null(vars)) {
    vars <- names(dplyr::select(data, where(is.numeric)))
  } else {
    vars <- tidyselect::eval_select(rlang::enquo(vars), data) |> names()
  }
  
  if (length(vars) == 0) {
    stop("No numeric variables found/selected.")
  }
  
  num <- data |>
    dplyr::select(dplyr::all_of(vars)) |>
    dplyr::summarise(
      dplyr::across(
        dplyr::everything(),
        list(
          N = ~sum(!is.na(.x)),
          Mean = ~mean(.x, na.rm = TRUE),
          SD = ~sd(.x, na.rm = TRUE),
          Min = ~min(.x, na.rm = TRUE),
          Max = ~max(.x, na.rm = TRUE)
        ),
        .names = "{.col}: {.fn}"
      )
    ) |>
    tidyr::pivot_longer(
      cols = dplyr::everything(),
      names_to = "Statistic",
      values_to = "Value"
    ) |>
    tidyr::separate(Statistic, into = c("Variable", "Stat"), sep = ": ") |>
    tidyr::pivot_wider(names_from = "Stat", values_from = "Value") |>
    dplyr::mutate(
      dplyr::across(where(is.numeric), \(x) round(x, digits))
    )
  
  if (include_range) {
    num <- num |>
      dplyr::mutate(Range = paste0(Min, " to ", Max))
  }
  
  keep <- c("Variable", "N", "Mean", "SD", "Min", "Max", if (include_range) "Range")
  num <- num |> dplyr::select(dplyr::all_of(keep))
  
  k <- num |>
    knitr::kable(
      format = "html",
      caption = caption,
      align = paste0("lrrrrr", if (include_range) "l" else ""),
      escape = TRUE
    ) |>
    kableExtra::kable_styling(full_width = FALSE)
  
  k <- .add_col_scope(k)
  k <- .make_first_col_rowheaders(k)  # optional, but nice for "Variable" as row header
  k
  
}

mk_dataset_summary <- function(data,
                               numeric_vars = NULL,
                               factor_vars  = NULL,
                               digits_num   = 2,
                               digits_pct   = 1,
                               include_range = TRUE,
                               include_na    = TRUE,
                               caption = NULL,
                               captions = list(
                                 numeric = "Summary statistics for numeric variables",
                                 factor  = "Distribution of categorical variables"
                               )) {
  stopifnot(is.data.frame(data))
  
  if (!is.null(caption)) {
    captions <- list(
      numeric = caption,
      factor  = caption
    )
  }
  
  if (!is.list(captions)) {
    stop("`captions` must be a list, e.g. list(numeric = '...', factor = '...').")
  }
  if (is.null(captions$numeric)) captions$numeric <- "Summary statistics for numeric variables"
  if (is.null(captions$factor))  captions$factor  <- "Distribution of categorical variables"
  
  eval_vars <- function(vars, data) {
    if (is.null(vars)) return(NULL)
    if (is.character(vars)) return(vars)
    tidyselect::eval_select(rlang::enquo(vars), data) |>
      names()
  }
  
  num_vars <- eval_vars(numeric_vars, data)
  fac_vars <- eval_vars(factor_vars, data)
  
  if (is.null(num_vars)) {
    num_vars <- names(dplyr::select(data, where(is.numeric)))
  }
  if (is.null(fac_vars)) {
    fac_vars <- names(dplyr::select(data, where(is.factor)))
  }
  
  out <- list()
  
  if (length(num_vars) > 0) {
    out$numeric <- mk_numeric_summary(
      data,
      vars = num_vars,
      digits = digits_num,
      caption = captions$numeric,
      include_range = include_range
    )
  } else {
    out$numeric <- NULL
  }
  
  if (length(fac_vars) > 0) {
    out$factor <- mk_factor_summary(
      data,
      vars = fac_vars,
      digits = digits_pct,
      caption = captions$factor,
      include_na = include_na
    )
  } else {
    out$factor <- NULL
  }
  
  if (!is.null(out$numeric)) print(out$numeric)
  if (!is.null(out$factor))  print(out$factor)
  
  invisible(out)
}

# ------------------------------------------------------------
# comparing models
# ------------------------------------------------------------

mk_coef_compare <- function(models,
                            model_names = NULL,
                            term_labels = NULL,
                            digits = 3,
                            show_ci = FALSE,
                            ci_level = 0.95,
                            vcov_list = NULL,
                            caption = "Coefficient comparison across models") {
  
  stopifnot(is.list(models))
  
  if (is.null(model_names)) {
    model_names <- paste("Model", seq_along(models))
  }
  
  stopifnot(length(model_names) == length(models))
  
  if (is.null(vcov_list)) {
    vcov_list <- vector("list", length(models))
  }
  
  stopifnot(length(vcov_list) == length(models))
  
  relabel_terms <- function(terms, term_labels) {
    if (is.null(term_labels)) return(terms)
    out <- terms
    hits <- terms %in% names(term_labels)
    out[hits] <- unname(term_labels[terms[hits]])
    out
  }
  
  tabs <- lapply(seq_along(models), function(i) {
    
    mod <- models[[i]]
    V   <- vcov_list[[i]]
    
    if (is.null(V)) {
      t <- broom::tidy(mod, conf.int = show_ci, conf.level = ci_level)
    } else {
      ct <- lmtest::coeftest(mod, vcov. = V)
      t <- data.frame(
        term = rownames(ct),
        estimate = ct[, 1],
        std.error = ct[, 2],
        stringsAsFactors = FALSE,
        row.names = NULL
      )
      
      if (show_ci) {
        alpha <- 1 - ci_level
        crit <- stats::qnorm(1 - alpha / 2)
        t$conf.low  <- t$estimate - crit * t$std.error
        t$conf.high <- t$estimate + crit * t$std.error
      }
    }
    
    keep <- c("term", "estimate", "std.error")
    if (show_ci) keep <- c(keep, "conf.low", "conf.high")
    
    t <- t[, keep, drop = FALSE]
    
    names(t) <- c(
      "term",
      paste0("b_", i),
      paste0("se_", i),
      if (show_ci) c(paste0("lo_", i), paste0("hi_", i))
    )
    
    t
  })
  
  out <- Reduce(function(x, y) dplyr::full_join(x, y, by = "term"), tabs)
  out$term <- relabel_terms(out$term, term_labels)
  
  out <- out |>
    dplyr::mutate(
      dplyr::across(where(is.numeric), \(x) round(x, digits))
    )
  
  col_names <- "Term"
  for (i in seq_along(models)) {
    col_names <- c(
      col_names,
      paste0(model_names[i], ": b"),
      paste0(model_names[i], ": SE")
    )
    
    if (show_ci) {
      col_names <- c(
        col_names,
        paste0(model_names[i], ": CI low"),
        paste0(model_names[i], ": CI high")
      )
    }
  }
  
  k <- knitr::kable(
    out,
    caption = caption,
    col.names = col_names,
    format = knitr::opts_knit$get("rmarkdown.pandoc.to")
  )
  
  if (requireNamespace("kableExtra", quietly = TRUE)) {
    k <- kableExtra::kable_styling(k, full_width = FALSE)
  }
  
  print(k)
  invisible(out)
}


mk_anova <- function(model,
                     term_labels = NULL,
                     caption = "ANOVA table",
                     digits = 3) {
  
  .require_pkg("broom")
  .require_pkg("knitr")
  
  has_kableextra <- requireNamespace("kableExtra", quietly = TRUE)
  
  tb <- broom::tidy(anova(model))
  
  tb$term <- .apply_term_labels(tb$term, term_labels)
  
  out <- data.frame(
    Term = tb$term,
    `df` = tb$df,
    `Sum Sq` = round(tb$sumsq, digits),
    `Mean Sq` = round(tb$meansq, digits),
    `F value` = round(tb$statistic, 2),
    `p value` = fmt_p(tb$p.value),
    check.names = FALSE
  )
  
  k <- knitr::kable(
    out,
    format = "html",
    escape = TRUE,
    caption = caption,
    align = c("l", rep("r", ncol(out) - 1)),
    row.names = FALSE
  )
  
  if (has_kableextra) {
    k <- k |>
      kableExtra::kable_classic(full_width = FALSE) |>
      kableExtra::row_spec(0, bold = TRUE)
  }
  
  k <- .make_first_col_rowheaders(k)
  k
}



mk_vif_table <- function(model, caption = "Variance Inflation Factors") {
  
  .require_pkg("car")
  .require_pkg("knitr")
  
  vif_tbl <- car::vif(model) %>%
    as.data.frame() %>%
    tibble::rownames_to_column("Term") %>%
    rename(VIF = 2)
  
  k <- knitr::kable(
    vif_tbl,
    format = "html",
    caption = caption,
    align = c("l","r"),
    row.names = FALSE
  )
  
  if (requireNamespace("kableExtra", quietly = TRUE)) {
    k <- k %>%
      kableExtra::kable_classic(full_width = FALSE) %>%
      kableExtra::row_spec(0, bold = TRUE)
  }
  
  .make_first_col_rowheaders(k)
}
                      