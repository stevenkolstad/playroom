ActiveAdmin.register Game do
  active_admin_import
  permit_params :name, :sku, :description, :difficulty, :game_time, :idps, :number_of_players, 
    :suggested_age, :youtube_link, :level_preschool, :level_first_primary, :level_second_primary, 
    :level_secondary, :cover_url, :game_type, game_skills_attributes: [:id, :_destroy, :skill_id], game_idps_attributes: [:id, :_destroy, :idp_id]

  menu priority: 3

  before_save do |game|
    game.name = game.name.upcase
  end

  index do
    selectable_column
    id_column
    column :name
    column "Descripción" do |game|
      !game.description.empty?
    end
    column "Portada" do |game|
      !game.cover_url.nil?
    end
    column "Habilidades" do |game|
      game.game_skills.any?
    end
    column "IDPS" do |game|
      game.idps.any?
    end
    column "Niveles" do |game|
      [game.level_preschool, game.level_first_primary, game.level_second_primary, game.level_secondary].any? { |x| x == true }
    end
    column "Ludotecas" do |game|
      game.playsets.any?
    end
    # column "Dificultad" do |game|
    #   !game.difficulty.nil?
    # end
    # column "Duración" do |game|
    #   !game.game_time.nil?
    # end
    # column "Nº de Jugadores" do |game|
    #   !game.number_of_players.empty?
    # end
    # column "Edad sugerida" do |game|
    #   !game.suggested_age.empty?
    # end
    column "Youtube Link" do |game|
      !game.youtube_link.nil?
    end
    actions
  end

  filter :name

  show do
    attributes_table do
        row :name
        row :sku
        row :description
        row :difficulty
        row :game_time           
        row :number_of_players
        row :suggested_age
        row :game_type
        row :youtube_link
        row :level_preschool
        row :level_first_primary
        row :level_second_primary
        row :level_secondary
        row "Portada" do |g|
          if g.cover_url.nil?
            nil
          else
            image_tag g.cover_url
          end
        end
    end
    panel "Ludotecas" do
      table_for game.game_sets do
        column "Nombre" do |gs|
          gs.playset.name
        end
      end
    end
    panel "Habilidades" do
      table_for game.game_skills do
        column "Nombre" do |gs|
          gs.skill.display_name
        end
      end
    end
    panel "IDPS" do
      table_for game.game_idps do
        column "Nombre" do |gs|
          gs.idp.name
        end
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :sku
      f.input :description, as: :text
      f.input :difficulty, :as => :select, :collection => ["inicial", "intermedio", "avanzado"]
      f.input :game_type, :as => :select, :collection => ["competitivo", "colaborativo", "semi-colaborativo"]
      f.input :game_time           
      f.input :number_of_players
      f.input :suggested_age, :as => :select, :collection => (0..15).to_a.map{|n| "Desde #{n} años"}
      f.input :youtube_link
      f.input :level_preschool
      f.input :level_first_primary
      f.input :level_second_primary
      f.input :level_secondary
      f.input :cover_url
      # f.input :image, as: :file
    end
    
    f.has_many :game_skills do |gs|
      gs.inputs "Habilidades" do
        gs.input :skill 
        if !gs.object.nil?
          gs.input :_destroy, :as => :boolean, :label => "Eliminar?"
        end
      end
    end

    f.has_many :game_idps do |gs|
      gs.inputs "IDPS" do
        gs.input :idp
        if !gs.object.nil?
          gs.input :_destroy, :as => :boolean, :label => "Eliminar?"
        end
      end
    end

    f.actions
  end


  csv do
    column :id
    column :name        
    column :description
    column :difficulty
    column :game_time
    column :idps
    column :number_of_players    
    column :suggested_age  
    column :level_preschool
    column :level_first_primary
    column :level_second_primary
    column :level_secondary
    column :youtube_link        
    column :cover_url
    #column('link_imagen') { |g| g.image.attached? ? url_for(g.image) : '' }     
    column :created_at     
    column :updated_at     
  end

end
