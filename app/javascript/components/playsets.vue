<template>
  <div class="playsets container-fluid">
    <div class="container">
      <carousel :autoplay="true" :perPage="1" :loop="true">
        <slide>
          <div class="bg bg-1"></div>
        </slide>
        <slide>
          <div class="bg bg-2"></div>
        </slide>
        <slide>
          <div class="bg bg-3"></div>
        </slide>
        <slide>
          <div class="bg bg-4"></div>
        </slide>
      </carousel>
      <!-- <p v-if="playsets.length == 0"><br><br> No hay Ludotecas cargadas en este establecimiento</p> -->

      <div class="columns is-3" >
          <div class="column is-one-third playset is-full-mobile" v-for="playset in playsets" v-bind:key="playset.id" v-bind:class="{ disabled: playset.disabled }">
            <div class="card">
              <div class="card-header">
                <p class="title">{{playset.playset_type}}</p>
              </div>
              <div class="card-image" @click.prevent="openPlaysetDetail(playset)">
                <figure class="image">
                  <img v-if="playset.image_url" v-lazy="playset.image_url" alt="ludoteca"> 
                </figure>
              </div>

            </div>

          </div>
      </div>
    </div>
     <b-modal :active.sync="isPlaysetModalActive" scroll="keep" id="playsetModal">
      <section v-if="currentPlayset">
        <div class="columns">
          <div class="column">
            <div><img height="100" v-bind:src="require('../images/pr3.png')"></div>
            
            <br>
            <p class="bd-notification is-info"><img v-bind:src="currentPlayset.image_url" alt="Ludoteca"></p>

            
          </div>
          <div class="column">
            <p class="title is-4">{{currentPlayset.playset_type}}</p>
            <br>
            <p><strong>Descripción:</strong>
            <p class="bd-notification is-info description">{{currentPlayset.description}}</p>            
            <div class="content" v-if="!currentPlayset.disabled"> 
                <button @click.prevent="goToPlayset(currentPlayset)" class="button is-light">
                  <span class="icon">
                    <i class="fas fa-book" aria-hidden="true"></i>
                  </span>
                  VER TODOS LOS JUEGOS ({{currentPlayset.number_of_games}})
                  </button>
            </div>
            <br>
          </div>        
        </div>
      </section>
    </b-modal>
  </div>
</template>

<script>

export default {
  name: 'Playsets',
  data() {
    return {
      isPlaysetModalActive: false,
      currentPlayset: null,
      carousels: [
          { text: 'Slide 1', color: 'primary' },
          { text: 'Slide 2', color: 'info' },
          { text: 'Slide 3', color: 'success' },
          { text: 'Slide 4', color: 'warning' },
          { text: 'Slide 5', color: 'danger' }
      ]
    };
  },
  computed: {
    playsets () {
      return this.$store.state.playsetStore.playsets
    }
  },
  mounted () {
    const vm = this
    this.$store.dispatch('playsetStore/index')
  },
  methods: {

    openPlaysetDetail(playset) {
      if (playset) {
        this.currentPlayset = playset
        this.isPlaysetModalActive = true
      }
    },

    goToPlayset (playset) {
      if (playset.disabled) return;
      this.$router.push({ path: 'games', query: { playsetId: playset.id }})

    },
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="scss" scoped>
@import "../utils.scss";

.playsets{
  background-color: #221f43;
  background-image: url("../../assets/images/fondo.png");
  background-repeat: no-repeat;
  background-size: cover;
  color: white;
  min-height: 90vh;
  margin-top: 130px;
 ::v-deep .modal-content{
    width: 100%;
    background: #0f0d2a;
    color:white;
    padding: 20px;
    strong{
      color: white;
    }
    img{
      max-width: 320px;
      display: block;
      margin: 30px auto;
    }
    .title{
      color: $white;
      text-transform: uppercase;
      margin-top: 20px;
      font-size: 30px;
    }
    .description{
      padding: 30px;
      text-align: justify;
    }
    button{
      background: transparent;
      border: 1px solid white;
      color: white;
      border-radius: 30px;
      height: 50px;
      padding: 0 30px;
      .icon{
        padding: 5px 25px;
        i{
          color: #00d8cd;
          opacity: 0.6;
        }
      }

    }
  }
  .bg{
    min-height: 50vh;
    background-size: cover;
    background-repeat: no-repeat;
    background-position: center;
    &.bg-1{
      background-image: url("../../assets/images/carousel1.jpeg");
    }
    &.bg-2{
      background-image: url("../../assets/images/carousel2.jpeg");
    }
    &.bg-3{
      background-image: url("../../assets/images/carousel3.jpeg");
    }
    &.bg-4{
      background-image: url("../../assets/images/carousel4.jpeg");
    }
  }
}

.columns{
  padding-top: 20px;
  padding-left: 50px;
  @media(max-width: 414px) {
    width: 105%;
    padding-left: 0;
  }
}

.playset{
  -webkit-box-shadow: 10px 10px 5px 0px rgba(0,0,0,0.75);
  -moz-box-shadow: 10px 10px 5px 0px rgba(0,0,0,0.75);
  box-shadow: 10px 10px 5px 0px rgba(0,0,0,0.75);
  background-color: #443c8f;
  margin: 10px;
  padding: 0px;
  width: 30%;
  height: 100%;
  opacity: 0.9;
  transition: all .6s ease;
  border-radius: 5px;

  .card{
      box-shadow: 0 1px 5px #00000099;
    transition-duration: 300ms;
    transition-property: transform, box-shadow;
    transition-timing-function: ease-out;
    transform: rotate3d(0);
    &:hover{
      transition-duration: 150ms;
      box-shadow: 0 5px 20px 5px #00000044;
    }
  }
  .card-header{
    height: 60px;
    padding: 10px;
    background-color: #443c8f;
  }
  .card-image{
    min-height: 310px;
    background-color: #443c8f;
  }
  p{
    color: white;
    text-transform: uppercase;
    font-size: 20px;
    text-align: center;
    width: 100%;
    margin-bottom: 10px;
  }
  img{
    background-color: #221f43;
  }
  &:hover{
    opacity: 1;
    cursor: pointer;
  }
  &.disabled{
    opacity: 0.56;
    cursor: not-allowed;
    img{
      -webkit-filter: grayscale(100%); /* Safari 6.0 - 9.0 */
      filter: grayscale(100%);
    }
  }
  @media(max-width: 414px) {
    width: 80%;
    margin: 20px auto;
  }
 
}

</style>
