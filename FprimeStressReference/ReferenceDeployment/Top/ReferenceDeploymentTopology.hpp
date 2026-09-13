// ======================================================================
// \title  ReferenceDeploymentTopology.hpp
// \brief  Topology setup / teardown entry points for the
//         ReferenceDeployment deployment.
// ======================================================================
#ifndef ReferenceDeployment_ReferenceDeploymentTopology_HPP
#define ReferenceDeployment_ReferenceDeploymentTopology_HPP

#include "FprimeStressReference/ReferenceDeployment/Top/ReferenceDeploymentTopologyDefs.hpp"

namespace ReferenceDeployment {

//! Initialize, configure, and start the ReferenceDeployment topology.
void setupTopology(const TopologyState& state);

//! Stop the rate-group driver, tear down all active component tasks,
//! and release any allocated resources.
void teardownTopology(const TopologyState& state);

//! Rate schedule: a ~70 Hz base timer divided into 35 / 10 / 1 Hz
//! rate groups. DOOM runs on the 35 Hz group, its native cadence.
static constexpr U32 BASE_TIMER_USEC = 14286;
static constexpr U32 DOOM_RATE_DIVIDER = 2;
static constexpr U32 DOOM_TICK_USEC = BASE_TIMER_USEC * DOOM_RATE_DIVIDER;

//! Drive the rate groups from the ~70 Hz base timer. Blocks until
//! stopRateGroups is called.
void startRateGroups();

//! Stop the rate-group driver loop started by startRateGroups.
void stopRateGroups();

}  // namespace ReferenceDeployment

#endif
