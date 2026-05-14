// ======================================================================
// \title  FprimeStressReferenceTopology.hpp
// \brief  Topology setup / teardown entry points for the
//         FprimeStressReference deployment.
// ======================================================================
#ifndef FprimeStressReference_FprimeStressReferenceTopology_HPP
#define FprimeStressReference_FprimeStressReferenceTopology_HPP

#include "Top/FprimeStressReferenceTopologyDefs.hpp"

namespace FprimeStressReference {

//! Initialize, configure, and start the FprimeStressReference topology.
void setupTopology(const TopologyState& state);

//! Stop the rate-group driver, tear down all active component tasks,
//! and release any allocated resources.
void teardownTopology(const TopologyState& state);

//! Drive the rate groups using a Linux software timer. Blocks until
//! stopRateGroups is called.
void startRateGroups(const Fw::TimeInterval& interval);

//! Stop the rate-group driver loop started by startRateGroups.
void stopRateGroups();

}  // namespace FprimeStressReference

#endif
