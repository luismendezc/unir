FROM elixir:1.14

WORKDIR /app

COPY . .

RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix deps.get && \
    mix compile

EXPOSE 4000

CMD ["elixir", "--no-halt", "-S", "mix", "run"]
