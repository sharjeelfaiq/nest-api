import createError from 'http-errors';
import { repository } from '#repository/index.js';

const { read } = repository;

export const commonUtils = {
  /**
   * Wrapper to handle promise rejections and throw HTTP errors
   * @param {Function} fn - async function to wrap
   * @returns {Function} - wrapped function
   */
  handlePromise:
    (fn) =>
    (...args) => {
      try {
        return fn(...args);
      } catch (error) {
        throw createError(error.status || 500, error.message);
      }
    },

  /**
   * Validate UUID
   * @param {string} id - UUID
   * @returns {void}
   */
  validateUuid: (id) => {
    if (!id) throw createError(400, 'Invalid Uuid.');

    const uuidRegex =
      /^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i;

    if (!uuidRegex.test(id)) throw createError(400, 'Invalid Uuid.');
  },

  /**
   * Generic helper to validate UUID and ensure a resource exists
   * @param {string} resourceName - the key in the repository (e.g., "inquiry", "admin")
   * @param {string} id - resource ID
   * @returns {Promise<Object>} - the resource
   */
  ensureResourceExists: async (resourceName, id) => {
    commonUtils.validateUuid(id);

    const existingResource = read[`${resourceName}ById`];
    if (!existingResource)
      throw new Error(`Unknown resource type: ${resourceName}`);

    const resource = await existingResource(id);
    if (!resource) throw createError(404, `${resourceName} does not exist.`);
    return resource;
  },
};
