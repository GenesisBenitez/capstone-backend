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

create table history(
    id int not null auto_increment,
    event_name varchar(200) not null,
    description varchar(5000) not null,
    year int not null,
    user_id int not null,
    country_id int not null,
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

create table book_comments(
    id int not null auto_increment,
    user_id int not null,
    book_id int not null,
    comment varchar(2000) not null,
    primary key(id),
    foreign key(user_id) references users(id),
    foreign key(book_id) references books(id)
);

create table history_comments(
    id int not null auto_increment,
    user_id int not null,
    history_id int not null,
    comment varchar(2000) not null,
    primary key(id),
    foreign key(user_id) references users(id),
    foreign key(history_id) references history(id)
);

-- insert statements
insert into countries(name, flag, language_id, capital)values('The United States of America', 'https://miro.medium.com/max/1200/0*o0-6o1W1DKmI5LbX.png', 1, 'Washington DC');
insert into languages(name)values('English');
insert into users(first_name, last_name, country_id, username, password,admin)values('Genesis', 'Benitez', 1, 'genesis', 'genesis', 'Y');