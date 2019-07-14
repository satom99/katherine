# Katherine

Sample project using the [Phoenix Framework](https://github.com/phoenixframework/phoenix).

### Installation

- Have a *MySQL* server running locally. A suitable solution could be
  [Mariadb](https://mariadb.org/).
- Create a new database and grant permissions to a user.
- Modify the
  [configuration file](https://github.com/satom99/katherine/blob/master/config/config.exs#L14-L17)
  accordingly with your database info.
- Run the ecto migrations via `mix ecto.migrate` in the app's directory.

### Usage

- Once installed, one may start the application via `iex -S mix` directly.
- All the listed routes below are assumed to be preceded by `localhost:4000/api`.
- Issue a `POST` request to `/user` to create a user account.
- Issue a `POST` request to `/auth` to authenticate and receive a token.
- Issue a `GET` request to `/user` to verify one is indeed authenticated.
- Issue a request to any of the other routes available.
- Know a [*Postman*](https://www.getpostman.com/products)
  [export](https://github.com/satom99/katherine/blob/master/routes.json)
  is also available.

### Routes

The following routes are implemented.

| Method | Route | Parameters | Authorzation |
| :----: | :---: | :--------: | :----------: |
| `POST` | `/user` | `username, password` |   |
| `GET`  | `/user` |   | ✓ |
| `POST` | `/auth` | `username, password` |   |
| `POST` | `/author` | `name, lastname` | ✓ |
| `GET`  | `/author/:id` |   |   |
| `PUT, PATCH` | `/author/:id` | `name, lastname` | ✓ |
| `DELETE` | `/author/:id` |   | ✓ |
| `POST` | `/book` | `name, description, authors` | ✓ |
| `GET`  | `/book/:id` |   |   |
| `PUT, PATCH` | `/book/:id` | `name, description, authors` | ✓ |
| `DELETE` | `/book/:id` |   | ✓ |

Those with a tick for `Authorization` require a header with a token to be provided.

### Note

Please do note that the permission system is indeed not very complex as is.\
This means that for instance
[all users](https://github.com/satom99/katherine/blob/master/web/routes/author.ex#L58-L60)
are denied access to all actions unless they are admin.\
One may however easily change this as the final project evolves into a more specific thing.
