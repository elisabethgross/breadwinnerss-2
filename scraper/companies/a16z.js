const cities = require('all-the-cities')
const _ = require('lodash')
const utils = require('../utils')

const usCities = _.map(_.filter(cities, (city) => {
  return city.country === 'US'
}), (city) => city.name)

class A16z {
  constructor (targetJobs, badJobs, targetDepts, badDepts, url, baseUrl, companyName, companyUrl, type) {
    this.name = companyName
    this.companyURL = companyUrl
    this.type = type
    this.url = url
    this.baseUrl = baseUrl
    this.targetElSelector = '.ptor-jobs-list__item'
    this.targetDepts = targetDepts || []
    this.badDepts = badDepts || []
    this.targetJobs = targetJobs || []
    this.badJobs = badJobs || []
  }
  // noop for now
  filterDepts (data, $) {
    const that = this
    const filteredDepts = data.filter(function () {
      const dept = $(this).closest('.ptor-jobs-list__department-section').find('h2').text()
      return utils.myFilter(that.targetDepts, that.badDepts, dept)
    })
    const ret = []
    filteredDepts.each(function () {
      const jobTitle = $(this).find('a').text()
      const url = $(this).find('a').attr('href')
      const location = $(this).find('.ptor-jobs-list__item-location').text()
      ret.push({
        jobTitle,
        location,
        url
      })
    })
    return ret
  }
  filterJobs (jobs) {
    return _.filter(jobs, (job) => _.includes(usCities, job.location))
  }
  findJob ($) {
    const jobEls = $(this.targetElSelector)
    const filteredByDeptjobs = this.filterDepts(jobEls, $)
    const jobs = this.filterJobs(filteredByDeptjobs)
    return jobs
  }
}

module.exports = A16z
