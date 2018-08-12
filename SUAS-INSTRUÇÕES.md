### Setup do projeto

- Instale o ruby (preferencialmente com a versão mais recente)

- Depois instale o bundle (gerenciador de dependencia)
```
gem install bundle
bundle install
```

### Como executar

### Console

```
irb -I . -r environment.rb
```

#### Testes

```
bundle exec rspec
```

#### Aplicação

```shellscript
bundle exec ruby summarization.rb input.log
```
