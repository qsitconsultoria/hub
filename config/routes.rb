Rails.application.routes.draw do
  devise_for :managers, controllers: { invitations: 'managers/invitations' }
  devise_for :users, path: '', path_names: { sign_in: 'login' }, controllers: { registrations: 'users/registrations' }

  devise_scope :user do
    get '/admin', to: 'devise/sessions#new'
  end

  mount Uploadbox::Engine => '/uploadbox', as: :uploadbox
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  # Sortable
  resource :sortables, only: [:update]

  # Admin ---------------------------------------------------------------

  namespace :admin do
    get 'permission/denied', as: :permission_denied

    resources :library_files, path: 'biblioteca' do
      collection do
        resources :authors, path: 'autores', controller: 'library/authors', only: [:index, :show]
        resources :themes, path: 'temas', controller: 'library/themes', only: [:index, :show]
        resources :territorial_coverages, path: 'abrangencia-territorial', controller: 'library/territorial_coverages', only: [:index, :show]
        resources :biomes, path: 'biomas', controller: 'library/biomes', only: [:index, :show]
        resources :courses, path: 'cursos', controller: 'library/courses', only: [:index, :show]
        resources :filetypes, path: 'tipos-de-arquivo', controller: 'library/filetypes', only: [:index, :show]
        resources :languages, path: 'idiomas', controller: 'library/languages', only: [:index, :show]
        resources :years, path: 'anos', controller: 'library/years', only: [:index, :show]
      end
    end

    resources :units, path: 'unidades' do
      resources :managers, except: :show

      resources :courses, path: 'cursos' do
        get 'duplicar' => 'courses#duplicate', as: :duplicate_course
        resources :subjects, path: 'modulos' do
          resources :questions, path: 'perguntas', except: [:index, :show]
          resources :topics, path: 'topicos', except: [:show]
        end
        resources :enrollments, path: 'alunos', only: [:index, :show] do
          get 'approve' => 'enrollments#approve', as: :approve_student
          get 'reject' => 'enrollments#reject', as: :reject_student
        end
        get 'alunos_ignorados' => 'enrollments#ignored', as: :ignored_students
        resources :teachers, except: :show
        resources :links, path: 'referencias', except: :show
        resources :forums do
          resources :forum_threads, path: 'threads'
        end
      end
    end
  end

  # Public ---------------------------------------------------------------
  resources :users, path: 'usuarios', only: [:edit, :update, :show]
  get 'permission/denied', as: :permission_denied

  resources :units, path: 'unidade', only: [:show] do
    resources :courses, path: 'curso', only: [:show] do
      resources :subjects, path: 'modulos', only: [:show] do
        resources :topics, path: 'topicos', only: [:show]
        resources :answers, path: 'respostas', except: [:index, :destroy]
      end

      resources :enrollments, path: 'matricula'
      get 'matricular' => 'enrollments#enroll_student', as: :enroll_student
      get 'matriculado' => 'enrollments#enrolled', as: :enrolled_student

      get 'forum' => 'forums#show'

      resources :forum_threads, path: 'forum/threads', except: [:index] do
        resources :forum_posts, path: 'post' do
          resources :replies, except: [:index]
        end
      end

      resources :links, path: 'biblioteca', except: :show
    end
  end

  resources :library_files, path: 'biblioteca', only: [:index, :show] do
    collection do
      get :autocomplete
    end
    resources :comments, except: [:index]
  end

  get 'instituto-chico-mendes/:id/' => 'courses#redirect_to_course'

  get 'instituto-chico-mendes' => 'units#instituto_chico_mendes'

  root 'home#index'

  # High_voltage ---------------------------------------------------------------
  get "pages" =>  'high_voltage/pages#show', as: :static_page, id: 'index'
end


