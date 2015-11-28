task :post_install_task => :environment do
  # rake db:migrate
  Rake::Task['db:migrate'].invoke

  # setup Postgresql Trigram feature
  connection = ActiveRecord::Base.connection
  connection.execute("CREATE EXTENSION pg_trgm")

end
