# active_scaffold.cr [![Build Status](https://travis-ci.org/maiha/active-scaffold.cr.svg?branch=master)](https://travis-ci.org/maiha/active-scaffold.cr)

ActiveScaffold for Amber on Crystal.
- amber-0.6.7
- granite-orm (maiha fork)
- crystal-0.24.1

## Installation

Add this to your amber application's `shard.yml`:

```yaml
dependencies:
  active_scaffold:
    github: maiha/active_scaffold.cr
    version: 0.3.7

  granite_orm:
    #github: amberframework/granite-orm
    github: maiha/granite-orm
    branch: master
```

## Usage

```crystal
require "active_scaffold"

class UsersController < ApplicationController
  include ActiveScaffold(User)

  active_scaffold do |config|
    # config.id = "code" # primary key (default: "id")

    config.columns = ["first_name", "last_name"]
    config.actions = ["list", "show"]
    config.action_links["show"].label = "View"

    config.list.paging.order  = "id DESC"
    config.list.paging.limit  = 15
    config.list.paging.window = 5
    # config.list.paging.count = false # disable `SELECT COUNT`

    config.show.label = "user(%s)"
  end
end
```

### Global settings

You can put global settings in `ActiveScaffold::Default` that sets default values to all controllers.

```crystal
ActiveScaffold::Default::List::PAGING = {limit: 5}
```

All configurable parameters are in `ActiveScaffold::Default`.
See https://github.com/maiha/active-scaffold.cr/wiki/API:-Global-settings

### Debug

- add `?debug` parameter to the url, or

```crystal
  active_scaffold do |config|
    config.debug = true
```

## API
- **config** : [ActiveScaffold::Config::Core](./src/active_scaffold/config/core.cr)
- **config.columns** : [ActiveScaffold::Data::Columns](./src/active_scaffold/data/columns.cr)
- **config.column** : [ActiveScaffold::Data::Column](./src/active_scaffold/data/column.cr)
- **config.action_links** : [ActiveScaffold::Data::ActionLinks](./src/active_scaffold/data/action_links.cr)
- **config.action_link** : [ActiveScaffold::Data::ActionLink](./src/active_scaffold/data/action_link.cr)
- **config.list** : [ActiveScaffold::Config::List](./src/active_scaffold/config/list.cr)
- **config.list.paging** : [ActiveScaffold::Data::Paging](./src/active_scaffold/data/paging.cr)
- **config.show** : [ActiveScaffold::Config::Show](./src/active_scaffold/config/show.cr)
- **config.edit** : [ActiveScaffold::Config::Edit](./src/active_scaffold/config/edit.cr)
- **config.update** : [ActiveScaffold::Config::Update](./src/active_scaffold/config/update.cr)

## Install

Currently, there are no full generators. So please setup files manually as follows.

### once for an application

- `public/dist/active_scaffold.css` -> `../../lib/active_scaffold/src/active_scaffold/assets/stylesheets/active_scaffold.css`
```shell
(cd public/dist && ln -s ../../lib/active_scaffold/src/active_scaffold/assets/stylesheets/active_scaffold.css)
```

- `src/views/layouts/application.slang`
  - add css to the end of `head` part
  - add js to the end of `body` part
```
link rel="stylesheet" href="/dist/active_scaffold.css"
script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"
```

Put into `shard.yml`.

```
targets:
  active_scaffold:
    main: lib/active_scaffold/bin/gen.cr
```

Then, build it.
```shell
shards build
```

### each controllers

For example, please run following command for `UsersController` and `User` model.

```shell
./bin/active_scaffold users
```

This writes following files if missing.

- `config/routes.cr`
- `src/models/user.cr`
- `src/controllers/users_controller.cr`
- `src/views/users` -> `../../lib/active_scaffold/src/active_scaffold/views`

## TODO

- data
  - [x] `ActiveScaffold::Data::Action(T)`
  - [x] `ActiveScaffold::Data::Actions(T)`
  - [x] `ActiveScaffold::Data::ActionLink(T)`
  - [x] `ActiveScaffold::Data::ActionLinks(T)`
  - [x] `ActiveScaffold::Data::Column(T)`
  - [x] `ActiveScaffold::Data::Columns(T)`
- config
  - [x] `ActiveScaffold::Configure(T)`
  - [x] `ActiveScaffold::Config::Base(T)`
  - [x] `ActiveScaffold::Config::Core(T)`
  - [x] `ActiveScaffold::Config::Edit(T)`
  - [x] `ActiveScaffold::Config::List(T)`
  - [ ] `ActiveScaffold::Config::Search(T)`
  - [x] `ActiveScaffold::Config::Show(T)`
- actions
  - [x] `ActiveScaffold::Actions::Create(T)`
  - [x] `ActiveScaffold::Actions::Delete(T)`
  - [x] `ActiveScaffold::Actions::Edit(T)`
  - [x] `ActiveScaffold::Actions::List(T)`
  - [x] `ActiveScaffold::Actions::New(T)`
  - [x] `ActiveScaffold::Actions::Show(T)`
  - [x] `ActiveScaffold::Actions::Update(T)`
- features
  - [x] debug
  - [x] pagination
  - [x] sorting
  - [x] global settings
  - [ ] ajax
  - [ ] search
  - [ ] in place editor
  - [ ] assosications
  - [ ] nested
  - [ ] generators
  - [ ] auths and roles
  - [ ] localizations

## Development

```shell
crystal spec -v
```

## Contributing

1. Fork it ( https://github.com/maiha/active_scaffold.cr/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [maiha](https://github.com/maiha) maiha - creator, maintainer
