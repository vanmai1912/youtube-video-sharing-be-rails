# Sử dụng image Ruby chính thức từ Docker Hub
FROM ruby:3.3.1

# Cài đặt các dependencies cần thiết
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Thiết lập thư mục làm việc
WORKDIR /myapp

# Sao chép Gemfile và Gemfile.lock vào container
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

# Cài đặt Gems
RUN bundle install

# Sao chép toàn bộ mã nguồn vào container
COPY . /myapp

# Mở cổng 3000 để ứng dụng Rails có thể lắng nghe các kết nối
EXPOSE 3000

# Lệnh để khởi chạy ứng dụng Rails
CMD ["bash", "-c", "rm -f tmp/pids/server.pid && bundle exec rails server"]
