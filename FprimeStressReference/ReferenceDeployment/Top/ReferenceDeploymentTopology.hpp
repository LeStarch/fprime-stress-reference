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

//! Drive the rate groups using a Linux software timer. Blocks until
//! stopRateGroups is called.
void startRateGroups(const Fw::TimeInterval& interval);

//! Stop the rate-group driver loop started by startRateGroups.
void stopRateGroups();

}  // namespace ReferenceDeployment

#endif
