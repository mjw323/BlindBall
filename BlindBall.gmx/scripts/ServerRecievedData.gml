/// Read incoming data to the server from a connected saocket
{  
    // get the buffer the data resides in
    var buff = ds_map_find_value(async_load, "buffer");
    
    // read ythe command 
    var cmd = buffer_read(buff, buffer_s16 );

    // Get the socket ID - this is the CLIENT socket ID. We can use this as a "key" for this client
    var sock = ds_map_find_value(async_load, "id");
    // Look up the client details
    var inst = ds_map_find_value(Clients, sock );

    // Is this a KEY command?
    if( cmd==KEY_CMD )    
    {
        // Read the key that was sent
        var key = buffer_read(buff, buffer_s16 );
        // And it's up/down state
        var updown = buffer_read(buff, buffer_s16 );
        
        var player = buffer_read(buff, buffer_s16 );
        
        var dodir=1;
    
        // translate keypress into an index for our player array.
        if( key==vk_left ) {
            key=LEFT_KEY;
        }
        else if( key==vk_right ) {
            key=RIGHT_KEY;
        }
        else if( key==vk_up ) {
            key=UP_KEY;
        }
        else if( key==vk_down) {
            key=DOWN_KEY;
        }
        else{dodir=0;}
         
        if dodir{
        // translate updown into a bool for the player array       
        if( updown==0 ){
            if player{inst.keys[key] = false;}
            else{inst.keys2[key] = false;}
            if inst.keys[key]<0{inst.keys[key]=0}
        }else{
            if player{inst.keys[key] = true;}
            else{inst.keys2[key] = true;}
            if inst.keys[key]>2{inst.keys[key]=2}
        }
        }
        else{ //tweet
        if( key==ord('D') ) {
            key=0;
        }
        else if( key==ord('W') ) {
            key=1;
        }
        else if( key==ord('A') ) {
            key=2;
        }
        else if( key==ord('S')) {
            key=3;
        }
        if player{inst.tweet[key] = 1;}
            else{inst.tweet2[key] = 1;}
        }
    }
    // Is this a NAME command?
    else if( cmd==NAME_CMD )    
    {
        // Set the client "name"
        inst.PlayerName = buffer_read(buff, buffer_string );    
    }
    else if( cmd==PING_CMD )
    {
        // keep alive - ignore it
    }
}


