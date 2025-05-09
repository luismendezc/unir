FROM perl:latest
RUN cpan App::cpanminus && cpanm HTTP::Daemon
WORKDIR /app
COPY app.pl .
EXPOSE 3000
CMD ["perl", "app.pl"]
