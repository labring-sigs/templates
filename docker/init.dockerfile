FROM bitnamilegacy/git
WORKDIR /data
RUN git clone https://github.com/labring-sigs/templates.git --depth=1
CMD ["sh", "-c", "ls -a /data/templates"]
