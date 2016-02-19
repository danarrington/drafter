Rails.application.routes.draw do

  get 'players/show' => 'players#show', as: :player_page

  root 'draft#welcome'

  devise_for :players
  get 'authentication/sign_in', as: :sign_in

  get 'new/create-draft' => 'draft#new', as: :new_draft
  post 'new/create-draft' => 'draft#create', as: :create_draft
  get 'new/:id/add-players' => 'draft#add_players', as: :add_players
  post 'new/:id/add-player' => 'draft#add_player', as: :add_player
  get 'new/:draft_id/add-draftees' => 'draftables#batch_new', 
    as: :add_draftable
  post 'new/:draft_id/add-draftees' => 'draftables#batch_create', 
    as: :save_draftables
  get 'new/:id/review' => 'draft#review', as: :review_draft
  post 'new/:id/start' => 'draft#start', as: :start_draft

  get 'picks/:draft_id/:player_id/:token' => 'picks#new', as: :pick
  post 'picks/make/:draft_id/:draftable_id' => 'picks#make', as: :make_pick
  get 'picks/make/:draft_id/:player_id/:draftable_id/:token' => 
    'picks#make', as: :make_pick_from_email

  if Rails.env.development?
      mount LetterOpenerWeb::Engine, at: "/emails"
  end
end
