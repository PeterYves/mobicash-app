/* eslint-disable eol-last */
<template>
  <div class="max-w-sm m-auto my-8 mt-3">
    <div class="border p-10 border-grey-light shadow rounded mt-3">
      <h3 class="text-2xl mb-6 text-grey-darkest">Sign Up</h3>
      <form @submit.prevent="signup">
        <div class="text-red" v-if="error">{{ error }}</div>

        <div class="mb-6">
          <label for="email">E-mail Address</label>
          <input type="email" v-model="email" class="input form-control" id="email" placeholder="youremail@gmail.com">
        </div>

        <div class="mb-6">
          <label for="password">Password</label>
          <input type="password" v-model="password" class="input form-control" id="password" placeholder="Password">
        </div>

        <div class="mb-6">
          <label for="password_confirmation">Password Confirmation</label>
          <input type="password" v-model="password_confirmation" class="input form-control" id="password_confirmation" placeholder="Password Confirmation">
        </div>
        <button type="submit" style="background:linear-gradient(120deg, #f6d365 0%, #fda085 100%)" class="font-sans font-bold px-4 rounded cursor-pointer no-underline bg-green hover:bg-green-dark block w-full py-4 text-white items-center justify-center">Sign Up</button>

        <div class="my-4"><router-link to="/" class="link-grey">Already have account?<b> Sign In</b></router-link></div>
      </form>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Signup',
  data () {
    return {
      email: '',
      password: '',
      password_confirmation: '',
      error: ''
    }
  },
  created () {
    this.checkedSignedIn()
  },
  updated () {
    this.checkedSignedIn()
  },
  methods: {
    signup () {
      this.$http.plain.post('/signup', { email: this.email, password: this.password, password_confirmation: this.password_confirmation })
        .then(response => this.signupSuccessful(response))
        .catch(error => this.signupFailed(error))
    },
    signupSuccessful (response) {
      if (!response.data.csrf) {
        this.signupFailed(response)
        return
      }
      localStorage.csrf = response.data.csrf
      localStorage.signedIn = true
      this.error = ''
      this.$router.replace('/customers')
    },
    signupFailed (error) {
      this.error = (error.response && error.response.data && error.response.data.error) || 'Something went wrong'
      delete localStorage.csrf
      delete localStorage.signedIn
    },
    checkedSignedIn () {
      if (localStorage.signedIn) {
        this.$router.replace('/customers')
      }
    }
  }
}
</script>
