# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'urls#index'

  resources :urls, only: %i[index create show], param: :url
  get 'latest/:amount', to: 'urls#latest', as: :latest
  get ':short_url', to: 'urls#visit', as: :visit
end
