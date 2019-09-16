import test from 'ava'
import Axios from 'axios'

test('check health', async ctx => {
  const response = await Axios.get('host.docker.internal:3000/health')

  ctx.is(response.status, 200)
  ctx.is(response.data, { health: 'OK' })
})
