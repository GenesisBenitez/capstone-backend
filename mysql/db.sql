create database capstone;

create table languages(
   id int not null auto_increment,
   name varchar(200),
   primary key(id) 
);

create table countries(
    id int not null auto_increment,
    name varchar(100) not null,
    flag varchar(2000) not null,
    language_id int not null,
    capital varchar(100) not null,
    primary key(id),
    foreign key(language_id) references languages(id)
);

create table users(
    id int not null auto_increment,
    first_name varchar(100) not null,
    last_name varchar(100) not null,
    country_id int not null,
    username varchar(100) not null,
    admin varchar(1) not null,
    password varchar(100) not null,
    primary key(id),
    foreign key(country_id) references countries(id)
);

create table films(
    id int not null auto_increment,
    title varchar(200) not null,
    description varchar(2000) not null,
    release_year int not null,
    language_id int not null,
    length int not null,
    user_id int not null,
    country_id int not null,
    primary key(id),
    foreign key(language_id) references languages(id),
    foreign key(user_id) references users(id),
    foreign key(country_id) references countries(id)
);

create table authors(
    id int not null auto_increment,
    first_name varchar(100) not null,
    last_name varchar(100) not null,
    primary key(id)
);

create table books(
    id int not null auto_increment,
    title varchar(200) not null,
    description varchar(2000) not null,
    release_year int not null,
    language_id int not null,
    author_id int not null,
    user_id int not null,
    country_id int not null,
    primary key(id),
    foreign key(language_id) references languages(id),
    foreign key(author_id) references authors(id),
    foreign key(user_id) references users(id),
    foreign key(country_id) references countries(id)
);

create table history_topics(
    id int not null auto_increment,
    name varchar(200) not null,
    description varchar(5000) not null,
    user_id int not null,
    country_id int not null,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    primary key(id),
    foreign key(user_id) references users(id),
    foreign key(country_id) references countries(id)
);
create table film_comments(
    id int not null auto_increment,
    user_id int not null,
    film_id int not null,
    comment varchar(2000) not null,
    primary key(id),
    foreign key(user_id) references users(id),
    foreign key(film_id) references films(id)
);

create table film_likes(
    id int not null auto_increment,
    user_id int not null,
    film_id int not null,
    film_like int not null,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    primary key(id),
    foreign key(user_id) references users(id),
    foreign key(film_id) references films(id)
);

create table book_comments(
    id int not null auto_increment,
    user_id int not null,
    book_id int not null,
    comment varchar(2000) not null,
    primary key(id),
    foreign key(user_id) references users(id),
    foreign key(book_id) references books(id)
);

create table book_likes(
    id int not null auto_increment,
    user_id int not null,
    book_id int not null,
    book_like int not null,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    primary key(id),
    foreign key(user_id) references users(id),
    foreign key(book_id) references books(id)
);
create table history_topic_likes(
    id int not null auto_increment,
    user_id int not null,
    history_topic_id int not null,
    history_topic_like int not null,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    primary key(id),
    foreign key(user_id) references users(id),
    foreign key(history_topic_id) references history_topics(id)
);

create table history_topic_comments(
    id int not null auto_increment,
    user_id int not null,
    history_topic_id int not null,
    comment varchar(2000) not null,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    primary key(id),
    foreign key(user_id) references users(id),
    foreign key(history_topic_id) references history_topics(id)
);



-- insert statements
insert into countries(name, flag, language_id, capital)values('The United States of America', 'https://miro.medium.com/max/1200/0*o0-6o1W1DKmI5LbX.png', 1, 'Washington DC');
insert into languages(name)values('English');
insert into users(first_name, last_name, country_id, username, password,admin,bio,avatar,email)values('Jim', 'Jones', 1, 'jim', 'jim', 'N','A simple man that loves history', 'https://cdn-icons.flaticon.com/png/512/1785/premium/1785911.png?token=exp=1650668325~hmac=694362273e031a750e7347b964f20ca3','jimjones123@hotmail.com');
insert into books(title,description,release_year,language_id,author_id,user_id,country_id,cover)values('El Cipitío', 'Based on a Nahuatl legend that for centuries has been passed down from generation to generation in the countryside of El Salvador, this tale compiles many of the adventures of a magical little elf who moves among flowers, rivers and jungle animals, befriending children who play away from their parents. This edition was magnificently illustrated by Vicky Ramos, a Costa Rican artist of enlightened sensitivity.', 2006,3,1,1,2,'https://images-na.ssl-images-amazon.com/images/I/519JY2FFkxL._SX340_BO1,204,203,200_.jpg');


--join statements
select countries.name, countries.capital, countries.flag,
languages.name
from countries
inner join languages on countries.language_id = language_id

--country detailed info
select books.id,books.cover,
count(distinct book_comments.id) as book_comments_count,
count(distinct book_likes.id) as book_likes_count
from books
left join book_comments on book_comments.book_id = books.id
left join book_likes on book_likes.book_id = books.id
where books.country_id = 1
group by books.id