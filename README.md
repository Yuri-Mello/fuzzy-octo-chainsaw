### BackEnd Oxeanbits:

#### Requisitos:

- ruby-3.1.4
- sqlite3

Clone o projeto e ao executar:

```ruby
bundle install
rails db:migrate
rails db:seed
```
Será configurado uma aplicação rails contando com as seguintes funcionalidades:
- Usuário padrão admin@rotten e senha admin
- Página de login
- Rota para criação de novos usuários
- Rota para cadastrar novo filme
- Rota para cadastrar filmes em massa usando um arquivo .csv
- Rota para dar nota nos filmes
- Rota para dar notas à filmes em massa usando um arquivo .csv
- Exibir a média das notas de cada filme

Ao executar:

```ruby
rails s
```
Um servidor Puma será criado e o app pode ser aberto em http://localhost:3000/. Para executar as tarefas de importação em massa, será necessário rodar Sidekiq em outro terminal usando `bundle exec sidekiq`. É necessário uma instância de [redis](https://redis.io/docs/install/install-redis/) rodando.