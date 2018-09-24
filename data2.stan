data { int K;
      int N;
      int D;
      int<lower =1,upper =K> y[N];
      vector[D] x[N];
    }
    parameters {
      matrix[K,D] beta;
    }
    model {
      for (k in 1:K)
        beta[k] ~ normal(0, 5);
      for (n in 1:N)
        y[n] ~ categorical_logit(beta * x[n]);
    }
    generated quantities {
      int y_hat[N];
        for (i in 1:N) {
          y_hat[i] = categorical_rng(softmax(beta*x[i]));
        }

    }
