USE restaurant;
INSERT  user_role(client) VALUES('admin'),('manager'),('user'),('unknown');
INSERT user(username, email, password, role_id) VALUES
('admin', 'mail.redoge@gmail.com', 'admin',2),
 ('redoge', 'danylo.klas@gmail.com', 'user', 3);