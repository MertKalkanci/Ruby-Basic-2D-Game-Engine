require 'ruby2d'


@oyuncu = Square.new(x:200 , y:10 , size: 25,color: 'red',z:5)
@oyuncuxspd = 0
@oyuncuyspd = 0

terrain = set background: 'green'


@worldlimit = Square.new(x:0, y:0 ,size: 300,color: 'olive', z: 1)
col1 = Square.new(x:100, y:100 ,size: 30,color: 'blue', z: 1)


on :key_down do |event|
  if event.key == 'j'
    @oyuncuxspd = -2
    @oyuncuyspd = 0
  elsif event.key == 'l'
    @oyuncuxspd = 2
    @oyuncuyspd = 0
  elsif event.key == 'i'
    @oyuncuxspd = 0
    @oyuncuyspd = -2
  elsif event.key == 'k'
    @oyuncuxspd = 0
    @oyuncuyspd = 2
  end
end

def collisiondetectionworldlimit(worldlimit)

  if(worldlimit.contains? @oyuncu.x,@oyuncu.y)
  else
    #x detection for player
    if(@oyuncu.x < worldlimit.x)
      @oyuncu.x = worldlimit.x
      oyuncuxspd = 0
    elsif (@oyuncu.x > worldlimit.size)
      @oyuncu.x = worldlimit.size + worldlimit.x
      oyuncuxspd = 0
    end
    #y detection for player
    if(@oyuncu.y < worldlimit.y)
      @oyuncu.y = worldlimit.y
      oyuncuyspd = 0
    elsif (@oyuncu.y > worldlimit.size)
      @oyuncu.y = worldlimit.size + worldlimit.y
      oyuncuyspd = 0
    end
  end
end

def collisiondetectioncube(collisionobject,player,oyspd,oxspd)
#sol üst
  if(collisionobject.contains? player.x,player.y)
    if((player.x + player.size > collisionobject.x + collisionobject.size/2)&&(oyspd == 0))
      player.x = collisionobject.x + collisionobject.size
      oxspd = 0
    elsif(player.y> collisionobject.y)
      player.y = collisionobject.y + collisionobject.size
      oyspd = 0
    end
  end
  #sağ üst
  if(collisionobject.contains? player.x+player.size,player.y)
    if((player.x + player.size < collisionobject.x + collisionobject.size/2)&&(oyspd == 0))
      player.x = collisionobject.x - player.size
      oxspd = 0
    elsif(player.y> collisionobject.y)
      player.y = collisionobject.y + collisionobject.size
      oyspd = 0
      end
  end
  #sol arka
  if(collisionobject.contains? player.x,player.y+player.size)
    if((player.x + player.size > collisionobject.x + collisionobject.size/2)&&(oyspd == 0))
      player.x = collisionobject.x + collisionobject.size
      oxspd = 0
    elsif(player.y< collisionobject.y)
      player.y = collisionobject.y - player.size
      oyspd = 0
    end
  end
  #sag arka
  if(collisionobject.contains? player.x+player.size,player.y+player.size)
    if((player.x + player.size < collisionobject.x + collisionobject.size/2)&&(oyspd == 0))
      player.x = collisionobject.x - player.size
      oxspd = 0
    elsif(player.y< collisionobject.y)
      player.y = collisionobject.y - player.size
      oyspd = 0
    end
  end
end

update do
  @oyuncu.x += @oyuncuxspd
  @oyuncu.y += @oyuncuyspd
  collisiondetectioncube(col1,@oyuncu,@oyuncuyspd,@oyuncuxspd)
  collisiondetectionworldlimit(@worldlimit)
end

show

#bitiş
