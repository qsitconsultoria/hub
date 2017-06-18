Unit.destroy_all
unit = Unit.create!(name: 'Unidade de Teste')
Unit.create!(name: 'Instituto Chico Mendes')

Admin.destroy_all
Admin.create!(name: 'Admin User', email: 'admin@example.com', password: '123123123', unit: unit)

Manager.destroy_all
@manager = Manager.invite!(email: 'manager@example.com', name: 'Manager', units: [unit]) do |u|
  u.skip_invitation = true
end

Manager.accept_invitation!(:invitation_token => @manager.instance_variable_get(:@raw_invitation_token), :password => '123123123', :password_confirmation => '123123123')

Teacher.destroy_all
teacher = Teacher.create!(name: 'Teacher', email: 'teacher@example.com', password: '123123123', unit: unit)

Student.destroy_all
john = Student.create!(name: 'John', email: 'john@example.com',
                       password: '123123123', unit: unit,
                       works_on: 'Servidor Público Federal', scholarity_level: 'Superior completo',
                       field_of_operation: 'Tecnologia da Informação', is_public_server: true)
Student.create!(name: 'Mary', email: 'mary@example.com',
                password: '123123123', unit: unit,
                works_on: 'Indústria', scholarity_level: 'Ensino Técnico',
                field_of_operation: 'Engenharia Florestal', is_public_server: false)

Course.destroy_all
rails = Course.create!(name: 'Rails para iniciantes', subname: 'Você vai aprender de uma forma simples e divertida os fundamentos do Ruby on Rails, praticando com um exemplo real.', video: "<iframe data-behavior=\"elastic-video\" src=\"//www.youtube.com/embed/wFbw8gFbAwA?rel=0\" frameborder=\"0\" allowfullscreen=\"\" data-aspect-ratio=\"0.5625\"></iframe>", unit: unit)

Teaching.create! course: rails, teacher: teacher

scaffold = Subject.create!(name: 'Scaffold',
                           description: "Cras justo odio, dapibus ac facilisis in, egestas eget quam. Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                           course: rails, published_at: Date.today)
Topic.create!(name: 'Views',
              content: "<p>Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Nullam quis risus eget urna mollis ornare vel eu leo. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas sed diam eget risus varius blandit sit amet non magna.</p><p>Etiam porta sem malesuada magna mollis euismod. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Etiam porta sem malesuada magna mollis euismod. Maecenas sed diam eget risus varius blandit sit amet non magna. Nullam quis risus eget urna mollis ornare vel eu leo.</p><p>Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Sed posuere consectetur est at lobortis. Donec sed odio dui. Nullam quis risus eget urna mollis ornare vel eu leo.</p>\r\n            \r\n          ",
              subject: scaffold)
Topic.create!(name: 'Controllers',
              content: "<p>Sed posuere consectetur est at lobortis. Curabitur blandit tempus porttitor. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Nullam id dolor id nibh ultricies vehicula ut id elit. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit.</p><p>Vestibulum id ligula porta felis euismod semper. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Maecenas faucibus mollis interdum.</p><p>Maecenas sed diam eget risus varius blandit sit amet non magna. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Aenean lacinia bibendum nulla sed consectetur. Aenean lacinia bibendum nulla sed consectetur. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum.</p>\r\n            \r\n          ",
              subject: scaffold)
Topic.create!(name: 'Routes',
              content: "<p>Curabitur blandit tempus porttitor. Nulla vitae elit libero, a pharetra augue. Donec ullamcorper nulla non metus auctor fringilla. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Curabitur blandit tempus porttitor. Donec sed odio dui.</p><p>Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam porta sem malesuada magna mollis euismod. Donec id elit non mi porta gravida at eget metus. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Vestibulum id ligula porta felis euismod semper.</p><p>Nullam quis risus eget urna mollis ornare vel eu leo. Cras mattis consectetur purus sit amet fermentum. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor.</p>\r\n            \r\n          ",
              subject: scaffold)
Topic.create!(name: 'Models',
              content: "<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas faucibus mollis interdum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla vitae elit libero, a pharetra augue. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.</p><p>Vestibulum id ligula porta felis euismod semper. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Sed posuere consectetur est at lobortis. Sed posuere consectetur est at lobortis. Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Aenean lacinia bibendum nulla sed consectetur.</p><p>Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Aenean lacinia bibendum nulla sed consectetur. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Nullam quis risus eget urna mollis ornare vel eu leo. Donec sed odio dui.</p>\r\n            \r\n          ",
              subject: scaffold)

Question.create!(title: 'How much wood could a woodchuck chuck if a woodchuck could chuck wood?', subject: scaffold)

forum = rails.forum

forum_thread = ForumThread.create!(title: 'Scaffold',
                                   content: "<p>Nulla vitae elit libero, a pharetra augue. Vestibulum id ligula porta felis euismod semper. Sed posuere consectetur est at lobortis. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Curabitur blandit tempus porttitor.</p>\r\n      \r\n    ",
                                   forum: forum, user: @manager)
post = ForumPost.create!(content: 'Muito bom o conteúdo deste módulo!', forum_thread: forum_thread, user: john)
Reply.create!(content: 'Fico feliz que curtiu, John!', forum_post: post, user: teacher)

Biome.destroy_all
['Amazônia', 'Cerrado', 'Mata Atlântica', 'Caatinga', 'Pampas', 'Pantanal'].each do |name|
  Biome.create! name: name
end

TerritorialCoverage.destroy_all
['Internacional', 'Nacional', 'Região Norte', 'Região Nordeste', 'Região Sul', 'Região Sudeste', 'Região Centro-Oeste'].each do |territorial_coverage|
  TerritorialCoverage.create! name: territorial_coverage
end

Theme.destroy_all
[
  'Adaptação com base em ecossistemas',
  'Agropecuária',
  'Água',
  'Áreas Protegidas',
  'Assistência Técnica e Extensão Rural - ATER',
  'Atividades Produtivas Sustentáveis',
  'Biodiversidade (de Genes, Espécies e Ecossistemas)',
  'Biodiversidade',
  'Biomas',
  'Cadastro Ambiental Rural',
  'Cadeia de Valor e Arranjos Produtivos Locais',
  'Chamadas Públicas',
  'Cidades Sustentáveis',
  'Clima',
  'Concessão Florestal',
  'Contas de Floresta',
  'Contas de Água',
  'Contas Ecossistêmicas',
  'Crédito',
  'Desenvolvimento Rural',
  'Desenvolvimento Sustentável',
  'Desmatamento',
  'Diretrizes de Engajamento e Reports',
  'Economia dos Ecossistemas e da Biodiversidade - TEEB',
  'Educação Ambiental',
  'Elaboração de Projetos CAR',
  'Elaboração de Projetos',
  'Extensão Florestal',
  'Florestas comunitárias',
  'Florestas',
  'Fundos Climáticos',
  'Gestão Costeira',
  'Gestão de Bacias Hidrográficas',
  'Gestão de Conhecimento',
  'Gestão de Projetos',
  'Gestão Financeira',
  'Gestão Florestal',
  'Gestão Territorial',
  'Governança Ambiental',
  'Gênero',
  'Indígena',
  'Instrumentos de Planejamento e Ordenamento Territorial',
  'Instrumentos Econômicos para a Conservação de Recursos Naturais',
  'Integração Tema Ambiental e Setor Financeiro',
  'Introdução de Serviços Ecossistêmicos ao Planejamento do Desenvolvimento - ISE',
  'Licenciamento Ambiental',
  'Manejo Florestal Comunitário Familiar Não-Madeireiro',
  'Manejo Florestal Madeireiro',
  'Mercado Florestal',
  'Mitigação',
  'Monitoramento de Impactos',
  'Outras Capacitações',
  'Padrões e Certificações',
  'Patrimônio Genético',
  'Pecuária Sustentável',
  'Pesca e Aquicultura',
  'Políticas Públicas',
  'Projetos CAR',
  'REDD+',
  'Regularização Fundiária',
  'Relação Indústria e Biodiversidade',
  'Responsabilidade Socioambiental',
  'Segurança Química',
  'Serviços Ecossistêmicos',
  'Sistemas Agroflorestais'
].each { |name| Theme.create!(name: name) }
