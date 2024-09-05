import { init } from '@launchdarkly/node-server-sdk';
import { RedisFeatureStore } from '@launchdarkly/node-server-sdk-redis';

(async function main() {
  const client = init(process.env.LD_KEY!, {
    featureStore: RedisFeatureStore(),
  });
  await client.waitForInitialization({ timeout: 60 });
})();
