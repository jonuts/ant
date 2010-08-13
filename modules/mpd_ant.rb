# Music control module

Ant.register(:mpd) do
  require 'librmpd'

  def MPD.my_server
    @__my_server__ ||= new('localhost', 6600)
  end

  namespace "/mpd" do
    helpers do
      def mpd(*commands)
        server = MPD.my_server
        server.connect unless server.connected?

        # return the value of the last command sent
        commands.map {|c|
          server.send(c)
        }.last
      end
    end

    get do
      @song_info = mpd :current_song
      haml :'mpd/index'
    end

    post '/control' do
      command = params[:command]
      output = mpd command

      redirect '/mpd'
    end
  end
end

