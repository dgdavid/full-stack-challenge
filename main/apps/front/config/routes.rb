# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/

root to: 'city#show'
get '/:city', to: 'city#show'
