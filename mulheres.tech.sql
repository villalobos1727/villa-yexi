-- Apaga o banco de dados caso ele exista:
-- Isso é útil em "tempo de desenvolvimento".
-- Quando o aplicativo estiver pronto, isso NUNCA deve ser usado.
DROP DATABASE IF EXISTS mulherestech;

-- Recria o banco de dados:
-- CHARACTER SET utf8 especifica que o banco de dados use a tabela UTF-8.
-- COLLATE utf8_general_ci especifica que as buscas serão "case-insensitive".
CREATE DATABASE mulherestech CHARACTER SET utf8 COLLATE utf8_general_ci;

-- Seleciona banco de dados:
-- Todas as ações seguintes se referem a este banco de dados, até que outro
-- "USE nomedodb" seja encontrado.
USE mulherestech;

-- Cria a tabela users:
CREATE TABLE users (

    -- O campo uID (PK → Primary Key) é usado para identificar cada registro 
    -- como único. Ele não pode ter valores repetidos.
    -- A opção AUTO_INCREMENT força que o próprio MySQL incremente o uID.
    uid INT PRIMARY KEY AUTO_INCREMENT,

    -- A data do cadastro está no fomrato TIMESTAMP (AAAA-MM-DD HH:II:SS).
    -- Só funciona com datas à partir de 01/01/1970 (Unix timestamp).
    -- DEFAULT especifica um valor padrão para o campo, durante a inserção.
    -- CURRENT_TIMESTAMP insere a data atual do sistema neste campo.
    udate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 
    -- NOT NULL especifica que este campo precisa de um valor.
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    photo VARCHAR(255),

    -- Formato do tipo DATE → AAAA-MM-DD.
    birth DATE,

    -- O tipo TEXT aceita strings de até 65.536 caracteres. 
    bio TEXT,

    -- O tipo ENUM(lista) só aceita um dos valores de "lista".
    -- DEFAULT especifica um valor padrão para o campo, durante a inserção.
    -- Neste caso, DEFAULT deve ter um avalor presente na lista de ENUM.
    type ENUM('admin', 'author', 'moderator', 'user') DEFAULT 'user',

    -- Formato do tipo DATETIME → AAAA-MM-DD HH:II:SS.
    last_login DATETIME,
    ustatus ENUM('online', 'offline', 'deleted', 'banned') DEFAULT 'online'
);

-- Cadastra alguns usuários para testes:
INSERT INTO users (
    -- Listamos somente os campos onde queremos inserir dados.
    -- Os outros campos já inserem automaticamente, valores padrão (DEFAULT).
    uid,
    name,
    email,
    password,
    photo,
    birth,
    bio,
    type
) VALUES (
    -- Dados a serem inseridos nos campos.
    -- Muito cuidado com a ordem e a quantidade de dados,
    -- elas devem coincidir com os campos acima.
    '1',
    'Joca da Silva',
    'joca@silva.com',

    -- A senha será criptografada pela função SHA1 antes de ser inserida.
    SHA1('senha123'),
 
    -- Não vamos inserir a imagem diretamente no banco de dados.
    -- Buscamos a imagem pela URL dela.
    'https://randomuser.me/api/portraits/men/14.jpg',

    -- Lembre-se de sempre inserir datas e números no formato correto.
    '1990-12-14',
    'Pintor, programador, escultor e enrolador.',

    -- O campo "type" é do tipo ENUM e aceita somente os valores da lista.
    'author'
), 

-- Para inserir um novo registro, basta adicionar vírgula no final do anterior
-- e inserir os dados, sem repetir a query inteira.
-- Dependendo do sistema, pode haver algum limite máximo para o tamanho 
-- da query, portanto, evite repetir este processo muitas vezes.
(
    '2',
    'Marineuza Siriliano',
    'mari@neuza.com',
    SHA1('senha123'),
    'https://randomuser.me/api/portraits/women/72.jpg',
    '2002-03-21',
    'Escritora, montadora, organizadora e professora.',
    'author'
), (
    '3',
    'Hemengarda Sirigarda',
    'hemen@garda.com',
    SHA1('senha123'),
    'https://randomuser.me/api/portraits/women/20.jpg',
    '2004-08-19',
    'Sensitiva, intuitiva, normativa e omissiva.',
    'author'
), (
    '4',
    'Setembrino Trocatapas',
    'set@brino.com',
    SHA1('senha123'),
    'https://randomuser.me/api/portraits/men/20.jpg',
    '1979-02-03',
    'Um dos maiores inimigos do Pernalonga.',
    'author'
);

-- Cria tabela articles:
CREATE TABLE articles (
    aid INT PRIMARY KEY AUTO_INCREMENT,
    adate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    author INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    content LONGTEXT NOT NULL,
    thumbnail VARCHAR(255) NOT NULL,
    resume VARCHAR(255) NOT NULL,
    astatus ENUM('online', 'offline', 'deleted') DEFAULT 'online',
    views INT DEFAULT 0,

    -- Define author como chave estrangeira.
    -- Isso faz com que a tabela "articles" seja dependente da tabela "users"
    -- para receber valores.
    -- Somente o id de um usuário já cadastrado na tabela "users" pode ser 
    -- usado no campo "author" da tabela "articles".
    FOREIGN KEY (author) REFERENCES users (uid)
);

-- Insere alguns artigos para testes:
INSERT INTO articles (
    adate,
    author,
    title,
    content,
    thumbnail,
    resume
) VALUES (
    '2022-09-14 10:44:45',
    '1',
    'Por que as folhas são verdes',
    '<p> Lorem ipsum dolor sit amet consectetur adipisicing elit. Nemo quia provident reiciendis earum, tenetur reprehenderit iure ipsum fugit praesentium alias deserunt sed maiores id rerum odio delectus perferendis voluptatum totam!</p><p> Lorem ipsum dolor sit amet, consectetur adipisicing elit. Libero hic, modi pariatur culpa animi cum! Consequatur, odit! Repudiandae, dolorem temporibus, quaerat, unde enim error eum minus praesentium libero quibusdam consequuntur.</p><img src="https://picsum.photos/200/200" alt="Imagem aleatória." /><p> Lorem ipsum dolor sit amet consectetur adipisicing elit. Quia recusandae illum aliquam aperiam, laborum fugiat quos sunt expedita culpa! Minima harum mollitia aperiam nihil dolorem animi accusantium quia maxime expedita.</p><h3>Lista de links:</h3><ul><li><a href="https://github.com/Luferat">GitHub do Fessô</a></li><li><a href="https://catabits.com.br">Blog do Fessô</a></li><li><a href="https://facebook.com/Luferat">Facebook do Fessô</a></li></ul><p> Lorem, ipsum dolor sit amet consectetur adipisicing elit. Aliquam commodi inventore nemo doloribus asperiores provident, recusandae maxime quam molestiae sapiente autem, suscipit perspiciatis. Numquam labore minima, accusamus vitae exercitationem quod!</p>',
    'https://picsum.photos/200',
    'Saiba a origem da cor verde nas folhas das arvores que tem folhas verdes.'
), (
    '2022-09-26 14:55:45',
    '2',
    'Por que os peixes nadam',
    '<p> Lorem ipsum dolor sit amet consectetur adipisicing elit. Nemo quia provident reiciendis earum, tenetur reprehenderit iure ipsum fugit praesentium alias deserunt sed maiores id rerum odio delectus perferendis voluptatum totam!</p><p> Lorem ipsum dolor sit amet, consectetur adipisicing elit. Libero hic, modi pariatur culpa animi cum! Consequatur, odit! Repudiandae, dolorem temporibus, quaerat, unde enim error eum minus praesentium libero quibusdam consequuntur.</p><img src="https://picsum.photos/200/200" alt="Imagem aleatória." /><p> Lorem ipsum dolor sit amet consectetur adipisicing elit. Quia recusandae illum aliquam aperiam, laborum fugiat quos sunt expedita culpa! Minima harum mollitia aperiam nihil dolorem animi accusantium quia maxime expedita.</p><h3>Lista de links:</h3><ul><li><a href="https://github.com/Luferat">GitHub do Fessô</a></li><li><a href="https://catabits.com.br">Blog do Fessô</a></li><li><a href="https://facebook.com/Luferat">Facebook do Fessô</a></li></ul><p> Lorem, ipsum dolor sit amet consectetur adipisicing elit. Aliquam commodi inventore nemo doloribus asperiores provident, recusandae maxime quam molestiae sapiente autem, suscipit perspiciatis. Numquam labore minima, accusamus vitae exercitationem quod!</p>',
    'https://picsum.photos/199',
    'Alguns peixes nadam melhor que outros. Sabe por que?'
), (
    '2022-09-30 22:10:45',
    '2',
    'Quando as árvores tombam',
    '<p> Lorem ipsum dolor sit amet consectetur adipisicing elit. Nemo quia provident reiciendis earum, tenetur reprehenderit iure ipsum fugit praesentium alias deserunt sed maiores id rerum odio delectus perferendis voluptatum totam!</p><p> Lorem ipsum dolor sit amet, consectetur adipisicing elit. Libero hic, modi pariatur culpa animi cum! Consequatur, odit! Repudiandae, dolorem temporibus, quaerat, unde enim error eum minus praesentium libero quibusdam consequuntur.</p><img src="https://picsum.photos/200/200" alt="Imagem aleatória." /><p> Lorem ipsum dolor sit amet consectetur adipisicing elit. Quia recusandae illum aliquam aperiam, laborum fugiat quos sunt expedita culpa! Minima harum mollitia aperiam nihil dolorem animi accusantium quia maxime expedita.</p><h3>Lista de links:</h3><ul><li><a href="https://github.com/Luferat">GitHub do Fessô</a></li><li><a href="https://catabits.com.br">Blog do Fessô</a></li><li><a href="https://facebook.com/Luferat">Facebook do Fessô</a></li></ul><p> Lorem, ipsum dolor sit amet consectetur adipisicing elit. Aliquam commodi inventore nemo doloribus asperiores provident, recusandae maxime quam molestiae sapiente autem, suscipit perspiciatis. Numquam labore minima, accusamus vitae exercitationem quod!</p>',
    'https://picsum.photos/198',
    'Quando uma arvore cai na floresta e ninguém vê, ela realmente caiu ou foi derrubada?'
), (
    '2022-10-02 12:55:45',
    '4',
    'Esquilos tropeçam no ar',
    '<p> Lorem ipsum dolor sit amet consectetur adipisicing elit. Nemo quia provident reiciendis earum, tenetur reprehenderit iure ipsum fugit praesentium alias deserunt sed maiores id rerum odio delectus perferendis voluptatum totam!</p><p> Lorem ipsum dolor sit amet, consectetur adipisicing elit. Libero hic, modi pariatur culpa animi cum! Consequatur, odit! Repudiandae, dolorem temporibus, quaerat, unde enim error eum minus praesentium libero quibusdam consequuntur.</p><img src="https://picsum.photos/200/200" alt="Imagem aleatória." /><p> Lorem ipsum dolor sit amet consectetur adipisicing elit. Quia recusandae illum aliquam aperiam, laborum fugiat quos sunt expedita culpa! Minima harum mollitia aperiam nihil dolorem animi accusantium quia maxime expedita.</p><h3>Lista de links:</h3><ul><li><a href="https://github.com/Luferat">GitHub do Fessô</a></li><li><a href="https://catabits.com.br">Blog do Fessô</a></li><li><a href="https://facebook.com/Luferat">Facebook do Fessô</a></li></ul><p> Lorem, ipsum dolor sit amet consectetur adipisicing elit. Aliquam commodi inventore nemo doloribus asperiores provident, recusandae maxime quam molestiae sapiente autem, suscipit perspiciatis. Numquam labore minima, accusamus vitae exercitationem quod!</p>',
    'https://picsum.photos/201',
    'Bichinos fofinhos que podem transformar seu dia em um inferno de fofura.'
), (
    '2022-10-04 14:55:45',
    '3',
    'Impacto verde',
    '<p> Lorem ipsum dolor sit amet consectetur adipisicing elit. Nemo quia provident reiciendis earum, tenetur reprehenderit iure ipsum fugit praesentium alias deserunt sed maiores id rerum odio delectus perferendis voluptatum totam!</p><p> Lorem ipsum dolor sit amet, consectetur adipisicing elit. Libero hic, modi pariatur culpa animi cum! Consequatur, odit! Repudiandae, dolorem temporibus, quaerat, unde enim error eum minus praesentium libero quibusdam consequuntur.</p><img src="https://picsum.photos/200/200" alt="Imagem aleatória." /><p> Lorem ipsum dolor sit amet consectetur adipisicing elit. Quia recusandae illum aliquam aperiam, laborum fugiat quos sunt expedita culpa! Minima harum mollitia aperiam nihil dolorem animi accusantium quia maxime expedita.</p><h3>Lista de links:</h3><ul><li><a href="https://github.com/Luferat">GitHub do Fessô</a></li><li><a href="https://catabits.com.br">Blog do Fessô</a></li><li><a href="https://facebook.com/Luferat">Facebook do Fessô</a></li></ul><p> Lorem, ipsum dolor sit amet consectetur adipisicing elit. Aliquam commodi inventore nemo doloribus asperiores provident, recusandae maxime quam molestiae sapiente autem, suscipit perspiciatis. Numquam labore minima, accusamus vitae exercitationem quod!</p>',
    'https://picsum.photos/202',
    'Não esqueça de todos os itens necessários para adentrar uma grande floresta.'
), (
    '2022-10-10 23:59:59',
    '3',
    'Cheiro de mato',
    '<p> Lorem ipsum dolor sit amet consectetur adipisicing elit. Nemo quia provident reiciendis earum, tenetur reprehenderit iure ipsum fugit praesentium alias deserunt sed maiores id rerum odio delectus perferendis voluptatum totam!</p><p> Lorem ipsum dolor sit amet, consectetur adipisicing elit. Libero hic, modi pariatur culpa animi cum! Consequatur, odit! Repudiandae, dolorem temporibus, quaerat, unde enim error eum minus praesentium libero quibusdam consequuntur.</p><img src="https://picsum.photos/200/200" alt="Imagem aleatória." /><p> Lorem ipsum dolor sit amet consectetur adipisicing elit. Quia recusandae illum aliquam aperiam, laborum fugiat quos sunt expedita culpa! Minima harum mollitia aperiam nihil dolorem animi accusantium quia maxime expedita.</p><h3>Lista de links:</h3><ul><li><a href="https://github.com/Luferat">GitHub do Fessô</a></li><li><a href="https://catabits.com.br">Blog do Fessô</a></li><li><a href="https://facebook.com/Luferat">Facebook do Fessô</a></li></ul><p> Lorem, ipsum dolor sit amet consectetur adipisicing elit. Aliquam commodi inventore nemo doloribus asperiores provident, recusandae maxime quam molestiae sapiente autem, suscipit perspiciatis. Numquam labore minima, accusamus vitae exercitationem quod!</p>',
    'https://picsum.photos/203',
    'Conheça os melhores equipamentos para cortar sua grama de forma elegante e moderna.'
);

-- Cria a tabela "comments":
CREATE TABLE comments (
    cid INT PRIMARY KEY AUTO_INCREMENT,
    cdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    cautor INT NOT NULL,
    article INT NOT NULL,
    comment TEXT NOT NULL,
    cstatus ENUM('online', 'offline', 'deleted') DEFAULT 'online',
    FOREIGN KEY (cautor) REFERENCES users (uid),
    FOREIGN KEY (article) REFERENCES articles (aid)
);

-- Insere comentários para testes:
INSERT INTO comments (
    cautor,
    comment,
    article
) VALUES (
    '1',
    'Lorem ipsum dolor sit amet consectetur adipisicing elit. Nemo quia provident reiciendis earum, tenetur reprehenderit iure ipsum.',
    '3'
), (
    '2',
    'Lorem ipsum dolor sit amet consectetur adipisicing elit. Nemo quia provident reiciendis earum, tenetur reprehenderit iure ipsum.',
    '3'
), (
    '1',
    'Lorem ipsum dolor sit amet consectetur adipisicing elit. Nemo quia provident reiciendis earum, tenetur reprehenderit iure ipsum.',
    '4'
), (
    '3',
    'Lorem ipsum dolor sit amet consectetur adipisicing elit. Nemo quia provident reiciendis earum, tenetur reprehenderit iure ipsum.',
    '3'
), (
    '4',
    'Lorem ipsum dolor sit amet consectetur adipisicing elit. Nemo quia provident reiciendis earum, tenetur reprehenderit iure ipsum.',
    '4'
), (
    '1',
    'Lorem ipsum dolor sit amet consectetur adipisicing elit. Nemo quia provident reiciendis earum, tenetur reprehenderit iure ipsum.',
    '4'
), (
    '3',
    'Lorem ipsum dolor sit amet consectetur adipisicing elit. Nemo quia provident reiciendis earum, tenetur reprehenderit iure ipsum.',
    '6'
);

-- Cria a tabela "contacts":
CREATE TABLE contacts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    subject VARCHAR(255) NOT NULL,
    message TEXT NOt NULL,
    status ENUM('sended', 'readed', 'responded', 'deleted') DEFAULT 'sended'
);
