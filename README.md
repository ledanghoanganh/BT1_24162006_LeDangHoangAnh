# Bài tập 01 – Servlet, JSP/JSTL, JDBC, MVC ba tầng

## 1. Chức năng

- **Trang chính (`/`):** Tự động chuyển tiếp đến trang chủ hệ thống (`/views/index.jsp` - *HelloWorld - MainPage*) với giao diện Bootstrap hiện đại. Tự động nhận diện trạng thái phiên làm việc: hiển thị tùy chọn **Đăng nhập / Đăng ký** khi chưa đăng nhập, hoặc **Quản lý danh mục / Đăng xuất** khi đã đăng nhập.
- **Đăng nhập (`/login`):**
  - Xác thực thông tin tài khoản và mật khẩu thông qua `UserService` và `UserDao` truy vấn CSDL MySQL.
  - Lưu đối tượng `User` vào `HttpSession` (`account`) sau khi đăng nhập thành công.
  - Tùy chọn **"Nhớ tôi" (Remember Me)**: Khởi tạo Cookie `username` lưu trên trình duyệt (thời hạn 30 phút). Khi người dùng truy cập lại `/login`, hệ thống tự động kiểm tra Cookie để khôi phục phiên làm việc và chuyển tiếp tới `/waiting` mà không cần nhập lại mật khẩu.
- **Đăng ký tài khoản (`/register`):**
  - Kiểm tra tính hợp lệ của dữ liệu đầu vào: tài khoản, mật khẩu, họ tên, email, số điện thoại.
  - Tự động kiểm tra trùng lặp `username` và `email` trước khi thêm vào cơ sở dữ liệu.
  - Mọi tài khoản đăng ký mới được phân quyền mặc định là `roleid = 5` (Thành viên / Người dùng thông thường).
  - Đăng ký thành công tự động chuyển hướng sang trang đăng nhập `/login`.
- **Điều hướng phân quyền (`/waiting`):**
  - Đọc quyền hạn (`roleid`) của người dùng từ Session để điều hướng chính xác:
    - `roleid == 1` (Quản trị viên - Admin) $\rightarrow$ `/admin/home` (truy cập quản lý danh mục `/admin/category/list`).
    - `roleid == 2` (Quản lý - Manager) $\rightarrow$ `/manager/home`.
    - `roleid == 5` (Người dùng - User) $\rightarrow$ `/home`.
  - Chưa đăng nhập $\rightarrow$ Chuyển hướng về `/login`.
- **Đăng xuất (`/logout`):**
  - Hủy bỏ `HttpSession` hiện tại (`session.invalidate()`).
  - Xóa Cookie ghi nhớ tài khoản `username` trên cả context path và root `/` (`setMaxAge(0)`).
  - Thiết lập các header vô hiệu hóa bộ nhớ đệm HTTP (`Cache-Control: no-cache, no-store, must-revalidate`, `Pragma: no-cache`, `Expires: 0`) nhằm ngăn chặn việc sử dụng nút **Back** của trình duyệt để xem lại dữ liệu cũ.
  - Điều hướng người dùng quay trở lại trang `/login`.
- **Quản lý danh mục Category (`/admin/category/*` - Dành cho Admin):**
  - **Danh sách (`/admin/category/list`):** Hiển thị bảng toàn bộ danh mục kèm số thứ tự (STT), tên danh mục, hình ảnh đại diện và các nút thao tác Sửa / Xóa.
  - **Thêm danh mục (`/admin/category/add`):** Form nhập tên và upload file ảnh đại diện (hỗ trợ định dạng `multipart/form-data`). File upload được tự động đổi tên kèm timestamp hệ thống để tránh trùng lặp và lưu trữ an toàn vào thư mục lưu trữ ngoài (`D:\upload`).
  - **Chỉnh sửa danh mục (`/admin/category/edit`):** Cho phép cập nhật tên và thay đổi ảnh. Nếu không tải ảnh mới lên, hệ thống tự động giữ nguyên ảnh cũ; nếu tải ảnh mới, hệ thống tự động dọn dẹp file ảnh cũ trên ổ đĩa để tiết kiệm dung lượng.
  - **Xóa danh mục (`/admin/category/delete`):** Xóa bản ghi trong CSDL và đồng thời xóa file ảnh vật lý tương ứng trong thư mục lưu trữ.
  - **Tải & hiển thị ảnh (`/image?fname=...`):** `DownloadImageController` đọc file ảnh từ thư mục upload vật lý và stream trực tiếp dữ liệu nhị phân (MIME type `image/jpeg`) về trình duyệt của người dùng.
- **Bộ lọc bảo mật & phân quyền (`AdminFilter`):**
  - Chặn toàn bộ các request truy cập vào `/admin/*` và cả các đường dẫn trực tiếp đến file JSP `/views/admin/*`.
  - Ngăn chặn truy cập trái phép của khách vãng lai hoặc người dùng đã đăng xuất (đẩy về `/login`).
  - Ngăn chặn người dùng không có quyền quản trị (`roleid != 1`) truy cập vào các chức năng CRUD danh mục (đẩy về `/home`).
  - Áp dụng cơ chế bảo vệ đa lớp (Defense-in-depth) kết hợp `AdminFilter`, cấu hình `web.xml` và thẻ JSTL `<c:redirect url="/login" />` trên từng view JSP.

---

## 2. Môi trường & Công nghệ

- **Ngôn ngữ:** Java 21 (JDK 21.0.12.1 LTS).
- **Công cụ quản lý dự án:** Apache Maven 3.9+.
- **Web / Servlet Container:** Apache Tomcat 10.1.x (kiểm thử trên Apache Tomcat 10.1.61, hỗ trợ Tomcat 10.1 / Tomcat 11).
- **Hệ quản trị cơ sở dữ liệu:** MySQL 8.0+ (cổng mặc định `3306`).
- **Thư viện & Tiêu chuẩn:**
  - **Jakarta EE 10:** Jakarta Servlet API 6.1.0, Jakarta JSP API 3.1.0, Jakarta JSTL API 3.0.0 & GlassFish JSTL Implementation 3.0.1 (sử dụng namespace chuẩn `jakarta.*`).
  - **MySQL Connector/J:** 26.10.0 / 8.0+.
  - **Apache Commons IO:** 2.16.1 (xử lý stream hình ảnh).
  - **Giao diện (Frontend):** HTML5, CSS3, Bootstrap 3.4.1, Font Awesome 4.7.0.

---

## 3. Tạo cơ sở dữ liệu

Chạy các file script SQL nằm trong thư mục `database/` theo thứ tự bằng MySQL Command Line, MySQL Workbench hoặc DBeaver:

```powershell
mysql -u root -p < database/schema.sql
mysql -u root -p < database/init.sql
```

Hoặc mở và thực thi trực tiếp nội dung của 2 file:
1. `database/schema.sql`: Khởi tạo cơ sở dữ liệu `BanHang` (bảng mã `utf8mb4`), bảng `user` và bảng `category`.
2. `database/init.sql`: Chèn dữ liệu mẫu cho các tài khoản kiểm thử và danh mục ban đầu.

### Cấu hình kết nối Database

Thông tin kết nối CSDL được quản lý tập trung tại file [`src/main/java/baitap1/config/DBConnection.java`](src/main/java/baitap1/config/DBConnection.java):
- **URL:** `jdbc:mysql://localhost:3306/BanHang`
- **Username:** `root`
- **Password:** `140206` *(thay đổi theo mật khẩu MySQL trên máy của bạn nếu cần)*.

### Cấu hình thư mục lưu ảnh upload

Đường dẫn lưu ảnh được quản lý tại file [`src/main/java/baitap1/config/Constant.java`](src/main/java/baitap1/config/Constant.java):
- Mặc định: `D:\upload`
- **Lưu ý:** Vui lòng đảm bảo thư mục `D:\upload` đã được tạo sẵn trên ổ đĩa của máy trước khi thực hiện chức năng thêm danh mục kèm ảnh.

---

## 4. Build và chạy dự án

### Cách 1: Chạy trực tiếp trong Spring Tool Suite (STS) / Eclipse

1. Mở Eclipse / STS, chọn **File** $\rightarrow$ **Import...** $\rightarrow$ **Maven** $\rightarrow$ **Existing Maven Projects** $\rightarrow$ Trỏ tới thư mục chứa project `baitap1`.
2. Kiểm tra Java Build Path sử dụng **JDK 21**.
3. Cấu hình **Apache Tomcat 10.1** trong tab **Servers**.
4. Chuột phải vào project `baitap1` $\rightarrow$ chọn **Maven** $\rightarrow$ **Update Project...** (Alt + F5).
5. Chuột phải vào project $\rightarrow$ chọn **Run As** $\rightarrow$ **Run on Server** $\rightarrow$ chọn Apache Tomcat 10.1.
6. Mở trình duyệt và truy cập: **http://localhost:8080/baitap1/**

### Cách 2: Đóng gói file WAR và triển khai thủ công lên Tomcat

1. Mở terminal tại thư mục gốc của dự án:
   ```powershell
   mvn clean package
   ```
2. File WAR sẽ được sinh ra tại: `target/baitap1-1.1.0.war` (hoặc `target/baitap1.war`).
3. Sao chép file WAR vào thư mục `webapps/` của Apache Tomcat và đổi tên thành `baitap1.war`.
4. Khởi động Tomcat bằng lệnh `startup.bat` trong thư mục `bin/` của Tomcat.
5. Truy cập ứng dụng qua URL: **http://localhost:8080/baitap1/**

---

## 5. Tài khoản mẫu kiểm thử

| Tài khoản | Mật khẩu | Họ và tên | Vai trò (`roleid`) | Quyền hạn |
| :--- | :--- | :--- | :--- | :--- |
| **admin** | `123456` | Quản trị viên | `1` (Admin) | Toàn quyền quản trị danh mục (Xem, Thêm, Sửa, Xóa ảnh) |
| **user1** | `123456` | Nguyễn Văn A | `5` (User) | Thành viên thông thường, không thể vào trang `/admin/*` |

*(Bạn cũng có thể sử dụng trang `/register` để tạo thêm các tài khoản người dùng mới).*

---

## 6. Cấu trúc mô hình MVC ba tầng của Project

```text
baitap1/
├── database/
│   ├── schema.sql                         # Script khởi tạo CSDL BanHang, bảng user và category
│   └── init.sql                           # Script chèn dữ liệu mẫu cho tài khoản và danh mục
├── src/main/java/baitap1/
│   ├── config/                            # Cấu hình hằng số & kết nối CSDL
│   │   ├── Constant.java                  # Hằng số hệ thống, tên Cookie, thư mục upload
│   │   └── DBConnection.java              # Kết nối JDBC MySQL
│   ├── controller/                        # Tầng Servlet Controller đón nhận và điều phối request
│   │   ├── MainController.java            # Điều hướng trang chủ mặc định (/)
│   │   ├── HomeController.java            # Điều hướng trang Home cá nhân (/home, /admin/home, /manager/home)
│   │   ├── LoginController.java           # Xử lý đăng nhập & Cookie Remember Me (/login)
│   │   ├── RegisterController.java        # Xử lý đăng ký tài khoản mới (/register)
│   │   ├── WaitingController.java         # Điều hướng trang theo vai trò người dùng (/waiting)
│   │   ├── LogoutController.java          # Xử lý đăng xuất, xóa Cookie và hủy Session (/logout)
│   │   ├── CategoryListController.java    # Hiển thị danh sách danh mục (/admin/category/list)
│   │   ├── CategoryAddController.java     # Thêm danh mục mới & upload file ảnh (/admin/category/add)
│   │   ├── CategoryEditController.java    # Chỉnh sửa danh mục & cập nhật ảnh (/admin/category/edit)
│   │   ├── CategoryDeleteController.java  # Xóa danh mục & xóa file ảnh vật lý (/admin/category/delete)
│   │   └── DownloadImageController.java   # Đọc và hiển thị ảnh nhị phân từ ổ đĩa (/image)
│   ├── dao/                               # Tầng Data Access Object (Interface)
│   │   ├── UserDao.java
│   │   ├── CategoryDao.java
│   │   └── impl/                          # Triển khai truy vấn JDBC MySQL
│   │       ├── UserDaoImpl.java
│   │       └── CategoryDaoImpl.java
│   ├── filter/                            # Tầng Bộ lọc bảo mật
│   │   └── AdminFilter.java               # Bộ lọc phân quyền /admin/*, chặn cache trình duyệt
│   ├── model/                             # Tầng JavaBeans / Thực thể (Entities)
│   │   ├── User.java                      # Đối tượng người dùng (id, username, password, email, roleid,...)
│   │   └── Category.java                  # Đối tượng danh mục (cate_id, cate_name, icons)
│   └── service/                           # Tầng Business Logic Service (Interface)
│       ├── UserService.java
│       ├── CategoryService.java
│       └── impl/                          # Triển khai logic nghiệp vụ & kiểm tra dữ liệu
│           ├── UserServiceImpl.java
│           └── CategoryServiceImpl.java
├── src/main/webapp/
│   ├── views/                             # Tầng Presentation (JSP / JSTL)
│   │   ├── admin/
│   │   │   ├── list-category.jsp          # Giao diện bảng danh sách danh mục CRUD
│   │   │   ├── add-category.jsp           # Giao diện form thêm danh mục mới
│   │   │   └── edit-category.jsp          # Giao diện form chỉnh sửa danh mục
│   │   ├── index.jsp                      # Giao diện trang chính (MainPage)
│   │   ├── home.jsp                       # Giao diện trang chủ người dùng (HomePage)
│   │   ├── login.jsp                      # Giao diện form đăng nhập
│   │   ├── register.jsp                   # Giao diện form đăng ký
│   │   └── topbar.jsp                     # Giao diện thanh trạng thái đăng nhập
│   └── WEB-INF/
│       └── web.xml                        # Cấu hình Web Application Deployment Descriptor
├── pom.xml                                # File cấu hình dependencies Maven (Jakarta EE 10)
└── README.md                              # Tài liệu hướng dẫn sử dụng và kiểm thử dự án
```

---

## 7. Các bước kiểm tra thủ công (Manual Testing)

1. **Kiểm tra đăng nhập & Ghi nhớ đăng nhập (Remember Me):**
   - Đăng nhập với tài khoản `admin` / `123456`, tích chọn ô **Nhớ tôi**.
   - Sau khi đăng nhập thành công, tắt trình duyệt, mở lại và truy cập `http://localhost:8080/baitap1/login` $\rightarrow$ Hệ thống tự động nhận diện Cookie và đăng nhập vào hệ thống.
2. **Kiểm tra đăng ký tài khoản:**
   - Truy cập `/register`, nhập thử tài khoản trùng `admin` hoặc `user1` $\rightarrow$ Hệ thống cảnh báo tài khoản đã tồn tại.
   - Nhập thông tin tài khoản mới $\rightarrow$ Đăng ký thành công và tự động chuyển về `/login`.
3. **Kiểm tra phân quyền người dùng (Authorization):**
   - Đăng nhập bằng tài khoản `user1` / `123456` (roleid = 5).
   - Thử gõ trực tiếp URL quản trị: `http://localhost:8080/baitap1/admin/category/list` $\rightarrow$ Bộ lọc `AdminFilter` phát hiện không đủ quyền và tự động đẩy người dùng về `/home`.
4. **Kiểm tra chức năng CRUD danh mục & Quản lý ảnh (Admin):**
   - Đăng nhập bằng `admin` / `123456`.
   - Vào mục **Quản lý danh mục**, bấm **Thêm danh mục mới**, chọn ảnh từ máy $\rightarrow$ Danh mục xuất hiện trong danh sách kèm ảnh hiển thị đầy đủ.
   - Bấm **Sửa**: đổi tên danh mục (không chọn ảnh) $\rightarrow$ Danh mục đổi tên và ảnh cũ vẫn giữ nguyên.
   - Bấm **Sửa**: chọn ảnh mới $\rightarrow$ Ảnh mới được cập nhật, ảnh cũ trong `D:\upload` tự động được dọn dẹp.
   - Bấm **Xóa**: danh mục biến mất khỏi danh sách và file ảnh trên đĩa `D:\upload` bị xóa.
5. **Kiểm tra an toàn sau khi Đăng xuất (Logout & Cache Security):**
   - Bấm nút **Đăng xuất**.
   - Thử bấm nút **Back** trên trình duyệt $\rightarrow$ Trình duyệt không tải lại trang quản trị cũ mà giữ nguyên ở trang đăng nhập.
   - Thử gõ lại URL `http://localhost:8080/baitap1/admin/category/list` $\rightarrow$ Hệ thống ngay lập tức chuyển hướng về `/login`.
