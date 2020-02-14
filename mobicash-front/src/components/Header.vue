/* eslint-disable eol-last */
<template>
<div>
  <header class="nav navbar">
    <div class="container m-auto flex flex-wrap items-center justify-end">
      <div class="flex-1 flex items-center">
        <a href="/" class="logo-text"><b>mobi</b>cash</a>
      </div>
      <form method="GET" action="http://dev.mobivat.com:8080/vsdc_module/mobivat/api/product/productId?upc=224444445" v-if="signedIn()">
        <input type="text" name="upc" class="search form-control" style="float:left;width:70%;" placeholder="search product by upc">&nbsp;
        <input type="submit" class="btn btn-outline-light btn-sm" style="padding:6px" name="search_button" value="Search">
      </form>&nbsp;
      <div>
        <router-link to="/" class="btn-sm btn-success signinbtn" v-if="!signedIn()">Sign in</router-link>
        <router-link to="/signup" class="btn-sm btn-light signupbtn" v-if="!signedIn()">Sign Up</router-link>
         <a href="#" @click.prevent="signOut" class="signout btn btn-sm btn-outline-danger" v-if="signedIn()">Log out</a>
      </div>
    </div>
  </header>

  <aside class="nav navbar fixed" v-if="signedIn()">
    <div class="container m-auto flex flex-wrap items-center justify-end">
      <div>
        <router-link to="/customers" class="btn-sm btn-warning" v-if="signedIn()">Customers</router-link>
      </div>
    </div>
  </aside>
  </div>
</template>

<script>
export default {
  name: 'Header',
  created () {
    this.signedIn()
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    signedIn () {
      return localStorage.signedIn
    },
    signOut () {
      this.$http.secured.delete('/signin')
        .then(response => {
          delete localStorage.csrf
          delete localStorage.signedIn
          this.$router.replace('/')
        })
        .catch(error => this.setError(error, 'Cannot sign out'))
    }
  }
}
</script>
