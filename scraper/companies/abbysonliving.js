const utils = require('../utils')

class AbbysonLiving {
  constructor (targetJobs, badJobs, targetDepts, badDepts, url, baseUrl, companyName, companyUrl, type) {
    this.name = companyName
    this.companyURL = companyUrl
    this.type = type
    this.url = url
    this.targetElSelector = '.job-item'
    this.targetDepts = targetDepts || []
    this.badDepts = badDepts || []
    this.targetJobs = targetJobs || []
    this.badJobs = badJobs || []
  }
  // noop for now
  filterDepts () {

  }
  filterJobs (data, $) {
    const ret = []
    data.each(function () {
      const jobTitle = $(this).find('h4 > a').text()
      const location = $(this).find('p.job-location').text()
      const url = $(this).find('h4 > a').attr('href')
      ret.push({
        jobTitle,
        location,
        url
      })
    })
    return ret
  }
  findJob ($) {
    const jobEls = $(this.targetElSelector)
    const jobs = this.filterJobs(jobEls, $)
    return jobs
  }
}

module.exports = AbbysonLiving
