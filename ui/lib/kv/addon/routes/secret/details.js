/**
 * Copyright (c) HashiCorp, Inc.
 * SPDX-License-Identifier: MPL-2.0
 */

import Route from '@ember/routing/route';
import { inject as service } from '@ember/service';
import { hash } from 'rsvp';

export default class KvSecretDetailsRoute extends Route {
  @service store;

  queryParams = {
    version: {
      refreshModel: true,
    },
  };

  model(params) {
    const parentModel = this.modelFor('secret');
    if (params.version) {
      // query params have changed by selecting a different version from the dropdown
      // fire off new request for that version's secret data
      const { backend, path } = parentModel;
      return hash({
        ...parentModel,
        secret: this.store.queryRecord('kv/data', { backend, path, version: params.version }).catch(() => {
          // return empty record to access capability getters on model
          return this.store.createRecord('kv/data', { backend, path });
        }),
      });
    }
    return parentModel;
  }

  setupController(controller, resolvedModel) {
    super.setupController(controller, resolvedModel);
    controller.set('version', resolvedModel.secret.version);
  }

  resetController(controller, isExiting) {
    if (isExiting) {
      controller.set('version', null);
    }
  }
}